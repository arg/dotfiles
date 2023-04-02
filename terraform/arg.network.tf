terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type = string
  sensitive = true
}

resource "cloudflare_record" "arg_network_a" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "arg.network"
  value = "185.199.108.153"
  proxied = true
}

resource "cloudflare_record" "arg_network_b" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "arg.network"
  value = "185.199.109.153"
  proxied = true
}

resource "cloudflare_record" "arg_network_c" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "arg.network"
  value = "185.199.110.153"
  proxied = true
}

resource "cloudflare_record" "arg_network_d" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "arg.network"
  value = "185.199.111.153"
  proxied = true
}

resource "cloudflare_record" "adminer" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "adminer"
  value = "192.168.0.5"
  proxied = false
  comment = "MySQL web interface"
}

resource "cloudflare_record" "antares" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "antares"
  value = "192.168.0.6"
  proxied = false
  comment = "Ubuntu VM on Sirius"
}

resource "cloudflare_record" "downloads" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "downloads"
  value = "192.168.0.5"
  proxied = false
  comment = "Content downloader"
}

resource "cloudflare_record" "files" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "files"
  value = "192.168.0.5"
  proxied = false
  comment = "Synology Files"
}

resource "cloudflare_record" "monica" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "monica"
  value = "192.168.0.5"
  proxied = false
  comment = "Monica CRM"
}

resource "cloudflare_record" "numismat" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "numismat"
  value = "192.168.0.3"
  proxied = false
  comment = "Project"
}

resource "cloudflare_record" "photos" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "photos"
  value = "192.168.0.5"
  proxied = false
  comment = "Synology Photos"
}

resource "cloudflare_record" "plex" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "plex"
  value = "192.168.0.5"
  proxied = false
  comment = "Plex Media Server"
}

resource "cloudflare_record" "polaris" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "polaris"
  value = "192.168.0.5"
  proxied = false
  comment = "Synology DS720+"
}

resource "cloudflare_record" "prowlarr" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "prowlarr"
  value = "192.168.0.5"
  proxied = false
  comment = "Content search tool"
}

resource "cloudflare_record" "radarr" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "radarr"
  value = "192.168.0.5"
  proxied = false
  comment = "Movies organizer"
}

resource "cloudflare_record" "restclass" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "restclass"
  value = "192.168.0.3"
  proxied = false
  comment = "Project"
}

resource "cloudflare_record" "router" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "router"
  value = "192.168.0.1"
  proxied = false
  comment = "Unifi Dream Machine"
}

resource "cloudflare_record" "sirius" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "sirius"
  value = "192.168.0.4"
  proxied = false
  comment = "Intel NUC 10"
}

resource "cloudflare_record" "sonarr" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "sonarr"
  value = "192.168.0.5"
  proxied = false
  comment = "TV shows organizer"
}

resource "cloudflare_record" "sun" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "sun"
  value = "192.168.0.3"
  proxied = false
  comment = "Mac Mini M1 2020"
}

resource "cloudflare_record" "transmission" {
  zone_id = var.cloudflare_zone_id
  type = "A"
  name = "transmission"
  value = "192.168.0.5"
  proxied = false
  comment = "Content downloader"
}
# comment
