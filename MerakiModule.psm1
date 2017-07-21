#Insert your API key here

$base_url = 'https://dashboard.meraki.com/api/v0'


Function Set-MerakiApiKey ($key)
{

    $script:api_key = $key

     $script:header = @{
        
        "X-Cisco-Meraki-API-Key" = $api_key
        "Content-Type" = 'application/json'
        
    }


}


function Get-MerakiDevices ($networkID) {

    $uri = "{0}/networks/{1}/devices" -f $base_url, $networkid

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header

}

Function Get-MerakiSSIDs ($networkID) {

    $uri = "{0}/networks/{1}/ssids" -f $base_url, $networkid

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header


}

Function Get-MerakiSSID ($networkID, $number) {

    $uri = "{0}/networks/{1}/ssids/{2}" -f $base_url, $networkid, $number

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header


}

Function Get-MerakiVLANs ($networkID) {

    $uri = "{0}/networks/{1}/vlans" -f $base_url, $networkid


    Invoke-RestMethod -Method GET -Uri $uri -Headers $header


}




function Get-MerakiVPN {

    $api = @{

        "endpoint" = 'https://dashboard.meraki.com/api/v0'
    
    }

    $header = @{
        
        "X-Cisco-Meraki-API-Key" = $api_key
        "Content-Type" = 'application/json'
        
    }

    $api.url = '/organizations/INSERT_ORGANIZATION_ID/thirdPartyVPNPeers'
    $uri = $api.endpoint + $api.url
    $request = Invoke-RestMethod -Method GET -Uri $uri -Headers $header
    return $request

}

function Get-MerakiNetworks {

    $api = @{

        "endpoint" = 'https://dashboard.meraki.com/api/v0'
    
    }

    $header = @{
        
        "X-Cisco-Meraki-API-Key" = $api_key
        "Content-Type" = 'application/json'
        
    }

    $api.url = '/organizations/218691/networks'
    $uri = $api.endpoint + $api.url
    $request = Invoke-RestMethod -Method GET -Uri $uri -Headers $header
    return $request

}

function Get-MerakiOrganizations {
    [CmdletBinding()]
    param (
        [switch]$SetOrganizationID
        )

    $uri = "{0}/organizations" -f $base_url
    $request = Invoke-RestMethod -Method GET -Uri $uri -Headers $header

    #if switch is used save ID
    if ($SetOrganizationID -eq $true)
    {
        $script:organizationID = $request | select -First 1 | select -ExpandProperty ID

    }

    $request

}

function Get-MerakiSwitchPorts ($networkid, $serialnumber) {

           
    $uri = "{0}/networks/{1}/devices/{2}/switchPorts" -f $base_url, $networkid, $serialnumber

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header


}



function Get-MerakiInventory ($orgID)
{
    
    $list = New-Object System.Collections.ArrayList 

    #if param is used
    if ($orgID)
    {
        $OrganizationID = $orgID
    }
    
    $uri = "{0}/organizations/{1}/inventory" -f $base_url, $OrganizationID

    $result = Invoke-RestMethod -Method GET -Uri $uri -Headers $header

    foreach ($device in $result)
    {
        $device.claimedat = [DateTimeOffset]::FromUnixTimeSeconds($($device.claimedat)) | Get-Date -Format g
        [void]$list.Add($device)
    }

    $list
}


function Get-MerakiDeviceDetail ($networkid, $serialnumber)
{
    $uri = "{0}/networks/{1}/devices/{2}" -f $base_url, $networkid, $serialnumber

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header

}


function Get-MerakiDeviceUplink ($networkid, $serialnumber)
{
    $uri = "{0}/networks/{1}/devices/{2}/uplink" -f $base_url, $networkid, $serialnumber

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header

}

function Get-MerakiAdmins ($orgID){

        #if param is used
    if ($orgID)
    {
        $OrganizationID = $orgID
    }
    
    $uri = "{0}/organizations/{1}/admins" -f $base_url, $OrganizationID

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header

}


function Get-MerakiOrganization ($orgID){

        #if param is used
    if ($orgID)
    {
        $OrganizationID = $orgID
    }
    
    $uri = "{0}/organizations/{1}" -f $base_url, $OrganizationID

    Invoke-RestMethod -Method GET -Uri $uri -Headers $header

}

