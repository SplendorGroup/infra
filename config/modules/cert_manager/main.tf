resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }

  depends_on = [null_resource.install_cert_manager_crds]
}

resource "null_resource" "install_cert_manager_crds" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/cert-manager.sh"
  }
}

resource "helm_release" "cert_manager" {
  depends_on = [null_resource.install_cert_manager_crds]
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  version    = "v1.15.1"

  set {
    name  = "installCRDs"
    value = "false"
  }

}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = kubernetes_namespace.cert_manager.metadata[0].name
  }

  data = {
    api-token = base64encode(var.api_key)
  }
}

resource "null_resource" "wait_for_cert_manager_crds" {
  depends_on = [helm_release.cert_manager]

  provisioner "local-exec" {
    command = <<EOT
      for i in {1..30}; do
        if kubectl get crd clusterissuers.cert-manager.io; then
          echo "CRD clusterissuers.cert-manager.io found."
          exit 0
        fi
        echo "Waiting for CRD clusterissuers.cert-manager.io to be available."
        sleep 10
      done
      echo "CRD clusterissuers.cert-manager.io not found after 300 seconds."
      exit 1
    EOT
  }
}

resource "kubernetes_manifest" "letsencrypt_cluster_issuer" {
  depends_on = [null_resource.wait_for_cert_manager_crds]

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-prod"
    }
    spec = {
      acme = {
        email                 = var.cloudflare_email
        server                = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-prod"
        }
        solvers = [{
          dns01 = {
            cloudflare = {
              email            = var.cloudflare_email
              apiTokenSecretRef = {
                name = "cloudflare-api-token-secret"
                key  = "api-token"
              }
            }
          }
        }]
      }
    }
  }
}

resource "kubernetes_manifest" "wildcard_certificate" {
  depends_on = [kubernetes_manifest.letsencrypt_cluster_issuer]

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "wildcard-cert-tls"
      namespace = "default"
    }
    spec = {
      secretName = "wildcard-cert-tls"
      issuerRef = {
        name = "letsencrypt-prod"
        kind = "ClusterIssuer"
      }
      commonName = "*.gfrancodev.com"
      dnsNames   = ["*.gfrancodev.com"]
    }
  }
}
