# Use a specific Windows Server Core base image
# FROM mcr.microsoft.com/windows:ltsc2019
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install Chocolatey package manager
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Office 365 (includes Outlook)
RUN choco install office365business -y

# Enable RDP
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0; \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Set a password for the Administrator account
RUN net user Administrator /active:yes MySecurePassword123!

# Expose RDP port
EXPOSE 3389

# Start RDP server
CMD ["cmd", "/c", "start", "C:\\Windows\\System32\\mstsc.exe"]