variable "domain" {
  description = "Wildcard domain for the certificate"
  type        = string
}

variable "cloudflare_email" {
  description = "Email for Cloudflare"
  type        = string
}

variable "api_key" {
  description = "API key for Cloudflare"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}