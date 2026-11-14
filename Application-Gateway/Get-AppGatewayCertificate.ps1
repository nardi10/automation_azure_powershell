    Param(
        [String]$RG,
        [String]$AppGWName,
        [Switch]$Details,
        [Switch]$Export
    )   

    if($AppGWName -and $RG){
        $AppGWs = Get-AzApplicationGateway -ResourceGroupName $RG -Name $AppGWName
    }
    elseif($RG){
        $AppGWs = Get-AzApplicationGateway -ResourceGroupName $RG
    }
    elseif($AppGWName){
        throw "-AppGWName requires parameter -RG (ResourceGroup)"
    }
    else{
        $AppGWs = Get-AzApplicationGateway
    }

    $TemplateObject = New-Object PSObject | Select-Object AppGWName,ResourceGroupName,ListnerName,Subject,Issuer,SerialNumber,Thumbprint,NotBefore,NotAfter
    $TemplateObjectBackEnd = New-Object PSObject | Select-Object AppGWName,ResourceGroupName,HTTPSetting,RuleName,BackendCertName,Subject,Issuer,SerialNumber,Thumbprint,NotBefore,NotAfter

    Foreach($AppGW in $AppGWs){
        
        $httpsListeners = $AppGW.HttpListeners | Where-Object{$_.Protocol -eq "HTTPS"}
        foreach($httpsListener in $httpsListeners){
            $HTTPsListenerSSLCert = ($AppGW.SslCertificatesText | ConvertFrom-Json) | Where-Object{$_.Id -eq $httpsListener.SslCertificate.id}
            $HTTPsListenerSSLCertobj = [System.Security.Cryptography.X509Certificates.X509Certificate2]([System.Convert]::FromBase64String($HTTPsListenerSSLCert.PublicCertData.Substring(60,$HTTPsListenerSSLCert.PublicCertData.Length-60)))

            $WorkingObject = $TemplateObject | Select-Object *
            $WorkingObject.AppGWName = $AppGW.Name
            $WorkingObject.ResourceGroupName = $AppGW.ResourceGroupName
            $WorkingObject.ListnerName = $httpsListener.Name
            $WorkingObject.Subject = $HTTPsListenerSSLCertobj.Subject
            $WorkingObject.Issuer = $HTTPsListenerSSLCertobj.Issuer
            $WorkingObject.SerialNumber = $HTTPsListenerSSLCertobj.SerialNumber
            $WorkingObject.Thumbprint = $HTTPsListenerSSLCertobj.Thumbprint
            $WorkingObject.NotBefore = $HTTPsListenerSSLCertobj.NotBefore
            $WorkingObject.NotAfter = $HTTPsListenerSSLCertobj.NotAfter
            $WorkingObject

            if($Details){
                $HTTPsListenerSSLCertobj | Select-Object *
            }
            if($Export){
                [System.IO.File]::WriteAllBytes((Resolve-Path .\).Path+"\"+$AppGW.Name+"-"+$appGw.ResourceGroupName+"-"+$httpsListener.Name+".cer",$HTTPsListenerSSLCertobj.RawData) 
            }
        }

        $Rules = ($AppGW.RequestRoutingRulesText | ConvertFrom-Json)

        foreach($rule in $rules){

            $RuleHttpSettingsID = $rule.BackendHttpSettings.ID

            $BackendHttpSettings = ($AppGW.BackendHttpSettingsCollectionText | ConvertFrom-Json) |Where-Object{$_.Id -eq $RuleHttpSettingsID} | Where-Object{$_.Protocol -eq "HTTPS"}
            if($BackendHttpSettings -ne $null){
                $BackendHttpSettingsCerts = $BackendHttpSettings.AuthenticationCertificates
                foreach($BackendHttpSettingsCert in $BackendHttpSettingsCerts){
                    $BackendCerts = ($AppGW.AuthenticationCertificatesText | ConvertFrom-Json) | Where-Object{$_.id -eq $BackendHttpSettingsCert.id}
                    foreach($BackendCert in $BackendCerts){
                        $BackendCertObj = [System.Security.Cryptography.X509Certificates.X509Certificate2]([System.Convert]::FromBase64String($BackendCert.Data))
                        
                        $WorkingObjectBackEnd = $TemplateObjectBackEnd | Select-Object *
                        $WorkingObjectBackEnd.AppGWName = $AppGW.Name
                        $WorkingObjectBackEnd.ResourceGroupName = $AppGW.ResourceGroupName
                        $WorkingObjectBackEnd.RuleName = $rule.Name
                        $WorkingObjectBackEnd.HTTPSetting = $BackendHttpSettings.Name
                        $WorkingObjectBackEnd.BackendCertName = $BackendCert.Name
                        $WorkingObjectBackEnd.Subject = $BackendCertObj.Subject
                        $WorkingObjectBackEnd.Issuer = $BackendCertObj.Issuer
                        $WorkingObjectBackEnd.SerialNumber = $BackendCertObj.SerialNumber
                        $WorkingObjectBackEnd.Thumbprint = $BackendCertObj.Thumbprint
                        $WorkingObjectBackEnd.NotBefore = $BackendCertObj.NotBefore
                        $WorkingObjectBackEnd.NotAfter = $BackendCertObj.NotAfter
                        $WorkingObjectBackEnd
                        if($Details){
                            $BackendCertObj | Select-Object *
                        }
                        if($Export){
                            [System.IO.File]::WriteAllBytes((Resolve-Path .\).Path+"\"+$AppGW.Name+"-"+$appGw.ResourceGroupName+"-"+$rule.Name+"-"+$BackendHttpSettings.Name+"-"+$BackendCert.Name+".cer",$HTTPsListenerSSLCertobj.RawData) 
                        }
                    }
                }
            }
        }
    }



