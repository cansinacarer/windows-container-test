# Use a specific Windows Server Core base image
FROM mcr.microsoft.com/windows:ltsc2019

# Install necessary packages and the GUI application
# RUN powershell -Command \
#     Add-WindowsFeature Server-Gui-Mgmt-Infra, Server-Gui-Shell, Desktop-Experience; \
#     Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Set the entry point to the GUI application
# ENTRYPOINT ["powershell.exe", "Start-Process", "notepad.exe", "-NoNewWindow"]
RUN powershell New-Item c:\test
