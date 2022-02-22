# I***DNS

## About 
I***DNS is third party DNS appliance used for internal dns resolution. It has been integrated with on-Prem ADDNS for zone synchronization so that it can resolve the on-prem hosted private records from cloud instances.

As part of this I***DNS template, we can create following,
- **A Record** : An A record points your domain or subdomain to your application/Host IP address, which allows dns server to resolve the DNS queries.
- **CName Record** : A CNAME record or Canonical Name record matches a domain or subdomain to a different domain. With a CNAME record, DNS lookups use the target domain’s DNS resolution as the alias’s resolution.

With this setup, when Alias is requested, the initial DNS lookup will find the CNAME entry with the target of Canonical Name. A new DNS lookup will be started for Canonical Name, which will find the IP address IP address. Finally, visitors to Alias will be directed to IP address.

## Version compatibility

| Module version | Terraform version |
| -------------- | ----------------- |
| >= 1.0.0       | >= 1.0.11    |

## How to Consume

This module is optimized to work with the [infoblox-Provider](https://registry.terraform.io/providers/infobloxopen/infoblox/latest/docs) tool
which set some terraform variables in the environment needed by this module. For advanced configuration refer the input section for parameter detail.

You can use this module by including it this way:

```hcl

module "I***DNS" {
  
  source               = "https://github.com/venkat6597/MyCloud/tree/main/terraform-modules/3rdPartyDNS"
  RecordType           = var.RecordType
  Action               = var.Action
  fqdn                 = var.fqdn
  Environment          = var.Environment
  Alias_Record         = var.Alias_Record
  CanonicalName_Record = var.CanonicalName_Record

}
}

```

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| infoblox | >= 2.0.0 |

## Inputs
Fill following inputs in to create record in  Infoblox DNS.

|S. No|	Parameter Name|Description|Mandatory/Optional|
|---|------------------|------------------------------------|---------------------------------|
|1|IP|IP address to associcate with the A-record|Mandatory| 
|2|RecordType|DNS record type to be chosen|Mandatory| 
|3|Enironment|Environment Name to be chosen here(Production,NonProduction)|Mandatory| 
|4|fqdn|FQDN name should be provided.|Mandatory|
|5|Alias_Record|Alias record when requested ,the initial DNS lookup will find the CNAME entry with the target of Canonical Name.|Mandatory(when RecordType=CName-Record|
|6|CanonicalName_Record|Canonical Name is mapped to IP address , visitors to Alias will be directed to IP address.|Mandatory(when RecordType=CName-Record)|


## Outputs

| Name | Description |
|------|-------------|
| ARecord_ID | Id of the created ARecord |
| CName_Record_ID | Id of the created CName_Record |
<!-- END_TF_DOCS -->

## Related documentation



Terraform Documentation: [docs.terraform.com/en-us/azure/Infoblox-DNS/](https://registry.terraform.io/providers/infobloxopen/infoblox/latest/docs)
