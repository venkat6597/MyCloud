param (
    $mail,$action,$Zone,$RecordName,$IP,$ExistRecord,$RecordType,$Alias,$CRecord

)         
if ( $action -eq "Update") 
 {
          $Toaddress = $mail
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
                          "subject" = "Record update failed at Infoblox DNS"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Record update failed at Infoblox DNS due to invalid FQDN/IP or the record exists already, Below are the record details:- <p />  <br /> <b>FQDN :</b> $ExistRecord <br /> <b>IP :</b> $IP  <p />  <br /> Kindly check with Network team for further queries <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u> "
                                                            
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
            } elseif ( $action -eq "Add" -and $RecordType -eq "A-Record" ) {
                $Toaddress = $mail
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
                          "subject" = "Record already exist at Infoblox DNS"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Provided record already exists at Infoblox DNS, Below are the record details:- <p />  <br /> <b>FQDN :</b> $RecordName.$Zone <br /> <b>IP :</b> $IP  <p />  <br /> Kindly check with Network team for further queries <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u> "
                                                            
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
                
                
            } elseif ( $action -eq "Add" -and $RecordType -eq "CName-Record" ) {
                $Toaddress = $mail
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
                          "subject" = "Record already exist at Infoblox DNS"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Provided record already exists at Infoblox DNS, Below are the record details:- <p />  <br /> <b>Alias Record :</b>  $Alias  <br /> <b>Canonical Name Record :</b> $CRecord <p />  <br /> For further queries kindly check with Network team <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u> "
                                                            
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
                $Toaddress = $mail
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
                          "subject" = "Infoblox record entry failed"
                      }
                  )
                          "content"= @(
                                        @{
                                              "type" = "text/html"
                                              "value" = "Recordy entry failed while connecting to Infoblox DNS with error code 404 <p />  <br /> Kindly check with Network team for further queries <u>grp-dl-tcs-network-noc@marks-and-spencer.com</u>  "
                                                            
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
