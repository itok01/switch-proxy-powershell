$ProxyAddress = ''
$NoProxy = ''
$CampusNetworkSuffix = ''

$Proxies = ("HTTP_PROXY", "HTTPS_PROXY", "FTP_PROXY", "RSYNC_PROXY")

if ($(Get-DnsClient).ConnectionSpecificSuffix | Select-String $CampusNetworkSuffix) {
    for ($i = 0; $i -lt $Proxies.Length; $i++) {
        [System.Environment]::SetEnvironmentVariable($Proxies[$i], $ProxyAddress, "User")
    }
    [System.Environment]::SetEnvironmentVariable("NO_PROXY", $NoProxy, "User")

    Write-Output 'Enable proxy setting.'
} else {
    for ($i = 0; $i -lt $Proxies.Length; $i++) {
        [System.Environment]::SetEnvironmentVariable($Proxies[$i], '', "User")
    }
    [System.Environment]::SetEnvironmentVariable("NO_PROXY", '', "User")

    Write-Output 'Disable proxy setting.'
}