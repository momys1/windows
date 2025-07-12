clear
echo "The owner of this script will not be responsible if any unexpected problems occur whether you edit this script or not. It will start in 10 seconds and you agree to this. To cancel press Ctrl + C."
sleep 10
clear
run: Invoke-WebRequest -Uri "https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe" -OutFile "$env:USERPROFILE\playit.exe"
echo Start-Sleep -Seconds 5  # Give some time for the download to complete
run: Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
run: Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
run: Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
run: Set-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "p@ssw0rd!" -Force)
run: PLAYIT_AUTH_KEY: ${{ b6a51b8fa356eec3818dad732d33fc74de875a089e57e0de6c591222216ee660.PL }} 
run: Start-Process -FilePath "$env:USERPROFILE\playit.exe" -ArgumentList "--secret $env:PLAYIT_AUTH_KEY" -NoNewWindow -Wait
run: Start-Process -FilePath "$env:USERPROFILE\playit.exe" -NoNewWindow
run: Start-Sleep -Seconds 11800  # Adjust the duration based on your needs
