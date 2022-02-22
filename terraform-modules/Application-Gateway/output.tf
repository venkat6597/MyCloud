output "appgw_id" {
  description = "The ID of the Application Gateway."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].id : 0
}




output "appgw_subnet_id" {
  description = "The ID of the subnet where the Application Gateway is attached."
  value       = data.azurerm_subnet.gatewaysubnet.id
}

output "appgw_subnet_name" {
  description = "The name of the subnet where the Application Gateway is attached."
  value       = var.gateway_subnet_name
}



output "appgw_backend_address_pool_ids" {
  description = "List of backend address pool Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].backend_address_pool.*.id : null
}

output "appgw_backend_http_settings_ids" {
  description = "List of backend HTTP settings Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].backend_http_settings.*.id : null
}


output "appgw_frontend_ip_configuration_ids" {
  description = "List of frontend IP configuration Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].frontend_ip_configuration.*.id : null
}

output "appgw_frontend_port_ids" {
  description = "List of frontend port Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].frontend_port.*.id : null
}

output "appgw_gateway_ip_configuration_ids" {
  description = "List of IP configuration Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].gateway_ip_configuration.*.id : null
}

output "appgw_http_listener_ids" {
  description = "List of HTTP listener Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].http_listener.*.id : null
}

output "appgw_http_listener_frontend_ip_configuration_ids" {
  description = "List of frontend IP configuration Ids from HTTP listeners."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].http_listener.*.frontend_ip_configuration_id : null
}

output "appgw_http_listener_frontend_port_ids" {
  description = "List of frontend port Ids from HTTP listeners."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].http_listener.*.frontend_port_id : null
}

output "appgw_request_routing_rule_ids" {
  description = "List of request routing rules Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].request_routing_rule.*.id : null
}

output "appgw_request_routing_rule_http_listener_ids" {
  description = "List of HTTP listener Ids attached to request routing rules."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].request_routing_rule.*.http_listener_id : null
}

output "appgw_request_routing_rule_backend_address_pool_ids" {
  description = "List of backend address pool Ids attached to request routing rules."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].request_routing_rule.*.backend_address_pool_id : null
}

output "appgw_request_routing_rule_backend_http_settings_ids" {
  description = "List of HTTP settings Ids attached to request routing rules."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].request_routing_rule.*.backend_http_settings_id : null
}





output "appgw_ssl_certificate_ids" {
  description = "List of SSL certificate Ids."
  value       = var.application_gateway_create ? azurerm_application_gateway.app_gateway[0].ssl_certificate.*.id : null
}









