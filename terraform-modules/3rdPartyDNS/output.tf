output "id" {
  value = var.RecordType == "A-Record" ? data.infoblox_a_record.vip_host[0].id : 0
}

output "id2" {
  value = var.RecordType == "CName-Record" ? data.infoblox_cname_record.foo[0].id : 0
}
