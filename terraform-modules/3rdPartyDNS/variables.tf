
variable "IP" {
  default     = null
  type        = string
  description = "IP address to associate with the A-record"

}

variable "RecordType" {
  type        = string
  default     = null
  description = "DNS record type to be chosen"
  validation {
    condition = anytrue([
      var.RecordType == "A-Record",
      var.RecordType == "CName-Record"
    ])
    error_message = "RecordType name must be A-Record or CName-Record."

  }

}

# variable "Environment" {
#   type        = string
#   default     = null
#   description = "Environment Name to be chosen here"
#   validation {
#     condition = anytrue([
#       var.Environment == "Non-Production",
#       var.Environment == "Production"
#     ])
#     error_message = "Environment name must be Production or Non-Production."

#   }
# }



variable "fqdn" {
  default     = null
  type        = string
  description = "FQDN Name should be provided"


}





variable "Alias_Record" {
  default     = null
  type        = string
  description = "Alias record maps a name to another name but can coexist with other records on that name"
}

variable "CanonicalName_Record" {
  default     = null
  type        = string
  description = "Canonical Name is mapped to  IP address. visitors to Alias will be directed to IP address."


}
