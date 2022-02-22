param (
    $From,$RecordType,$Alias,$CRecord,$IP,$RecordName,$Zone,$Exist,$Action

)         
if ( $RecordType -eq "A-Record" -and $Action -ne "Update" )
 {
          $Toaddress = $From
          $FromAddress = "mailid" 
          $APIKey = ""
             $SendGridBody = @{
                  "personalizations" = @(
                      @{
                          "to" = @(
                                        @{
                                             "email" = $Toaddress
                                         }
                           )
                          "subject" = "Email notification for Infoblox DNS A-Record creation"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "$RecordType entry has been created in the Infoblox DNS with the below details:- <p />  <br /> <b>FQDN :</b> $RecordName.$Zone <br /> <b>IP :</b> $IP  <p />  <br /> For further queries kindly check with Network team <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u> "
                                                            
                                         }
                           )
                          "from" = @{
                                      "email" = $FromAddress
                                     }             
          }
              $BodyJson = $SendGridBody | ConvertTo-Json -Depth 4
              
              write-Host "json body" + $BodyJson 
              #Header for SendGrid API
              $Header = @{
                  "authorization" = "Bearer $APIKey "
              }
              #Send the email through SendGrid API
              $Parameters = @{
                  Method      = "POST"
                  Uri         = "https://api.sendgrid.com/v3/mail/send"
                  Headers     = $Header
                  ContentType = "application/json"
                  Body        = $BodyJson
              }
              Invoke-RestMethod  @Parameters
            }  elseif ( $RecordType  -eq "CName-Record" -and $Action -ne "Update" ) {
                $Toaddress = $From
                $FromAddress = "mailid"
                $APIKey = ""
                $SendGridBody = @{
                  "personalizations" = @(
                      @{
                          "to" = @(
                                        @{
                                             "email" = $Toaddress
                                         }
                           )
                          "subject" = "Email notification for Infoblox DNS CName-Record creation"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Infoblox DNS  $RecordType entry has been created with below details:- <p />  <br /> <b>Alias Record :</b>  $Alias  <br /> <b>Canonical Name Record :</b> $CRecord <p />  <br /> For further queries kindly check with Network team <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u> "
                                         }
                           )
                          "from" = @{
                                      "email" = $FromAddress
                                     }             
          }
              $BodyJson = $SendGridBody | ConvertTo-Json -Depth 4
              
              write-Host "json body" + $BodyJson 
              #Header for SendGrid API
              $Header = @{
                  "authorization" = "Bearer $APIKey "
              }
              #Send the email through SendGrid API
              $Parameters = @{
                  Method      = "POST"
                  Uri         = "https://api.sendgrid.com/v3/mail/send"
                  Headers     = $Header
                  ContentType = "application/json"
                  Body        = $BodyJson
              }
              Invoke-RestMethod  @Parameters
                
                
            } else {
                $Toaddress = $From
                $FromAddress = "mailid"
                $APIKey = ""
                $SendGridBody = @{
                  "personalizations" = @(
                      @{
                          "to" = @(
                                        @{
                                             "email" = $Toaddress
                                         }
                           )
                          "subject" = "Email notification for Infoblox DNS record update"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Infoblox DNS  A-Record entry has been updated with below details <p /> <br /> <b> FQDN :</b> $Exist <br /> <b>IP :</b> $IP <p />  <br /> For further queries kindly check with Network team <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u>  "
                                                            
                                         }
                           )
                          "from" = @{
                                      "email" = $FromAddress
                                     }             
          }
              $BodyJson = $SendGridBody | ConvertTo-Json -Depth 4
              
              write-Host "json body" + $BodyJson 
              #Header for SendGrid API
              $Header = @{
                  "authorization" = "Bearer $APIKey "
              }
              #Send the email through SendGrid API
              $Parameters = @{
                  Method      = "POST"
                  Uri         = "https://api.sendgrid.com/v3/mail/send"
                  Headers     = $Header
                  ContentType = "application/json"
                  Body        = $BodyJson
              }
              Invoke-RestMethod  @Parameters
                
                
            } 
