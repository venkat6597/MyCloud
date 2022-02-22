terraform {
  required_providers {

    infoblox = {
      source  = "infobloxopen/infoblox"
      version = "2.0.1"
    }
  }
}


# provider "infoblox" {
#   username = "infobloxapi"
#   password = "Cloud@2019"
#   server   = var.Environment == "Non-Production" ? "10.126.241.36" : "10.150.241.36"
# }

data "infoblox_a_record" "vip_host" {
  count    = var.RecordType == "A-Record" ? 1 : 0
  dns_view = "MNSINTERNAL"
  fqdn     = var.fqdn
  ip_addr  = var.IP

  depends_on = [
    infoblox_a_record.record
  ]
}

data "infoblox_cname_record" "foo" {
  count     = var.RecordType == "CName-Record" ? 1 : 0
  dns_view  = "MNSINTERNAL"
  alias     = var.Alias_Record
  canonical = var.CanonicalName_Record

  depends_on = [
    infoblox_cname_record.cname_record
  ]

}

resource "infoblox_a_record" "record" {
  # the zone 'example.com' MUST exist in the DNS view ('default')
  count    = var.RecordType == "A-Record" ? 1 : 0
  dns_view = "MNSINTERNAL"
  fqdn     = var.fqdn
  ip_addr  = var.IP
  ttl      = 10
  comment  = "static A-record #1"
  ext_attrs = jsonencode({
    "CMP Type"        = "azure"
    "Tenant ID"       = "bd5c6713-7399-4b31-be79-78f2d078e543"
    "Cloud API Owned" = "True"
  })
}


resource "infoblox_cname_record" "cname_record" {
  count     = var.RecordType == "CName-Record" ? 1 : 0
  dns_view  = "MNSINTERNAL"
  canonical = var.CanonicalName_Record
  alias     = var.Alias_Record
  ttl       = 3600

  comment = "static CName-record #"
  ext_attrs = jsonencode({
    "CMP Type"        = "azure"
    "Tenant ID"       = "bd5c6713-7399-4b31-be79-78f2d078e543"
    "Cloud API Owned" = "True"
  })
}


