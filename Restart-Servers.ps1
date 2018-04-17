#PowerShell Script reboot multiple servers from text file one at a time
#
#################################################################
function Get-Sleep {
    
    Write-Host "Please wait..."
        foreach($element in 1..60){
        Write-Host -NoNewline  "${element} " -foreground yellow 
        Start-Sleep –Seconds 1
}
    Write-Host ""
}#################################################################

$StartDate=(GET-DATE)
$nServers=0

cls
Write-Host $(Get-Date -Format D)
Write-Host $(Get-Date -Format T)
Write-Host "--------------------------"
$content = Read-Host "Please provide the path of the Server Restart text file"

$FileExists = Test-Path $content
 
If ($FileExists -eq $True) 
    {
        #Write-Host "Rebooting servers..."
        
        foreach($server in Get-Content $content) {
                $nServers=$nServers + 1
                Write-Host -nonewline "Rebooting server "; Write-Host $server -ForegroundColor Yellow
                Restart-Computer -ComputerName $server -Wait -for Wmi -Force
                Get-Sleep
        }       
        
        
        $EndDate=(GET-DATE)
        $Duration=NEW-TIMESPAN –Start $StartDate –End $EndDate
        
        Write-Host "Time took to reboot " $($nServers) " servers: "  "$($DURATION.Minutes)" " minutes."
        Write-Host "All completed."
    }

Else {Write-Host "No file at this location."} 
