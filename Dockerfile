# Use a specific Windows Server Core base image
# FROM mcr.microsoft.com/windows:ltsc2019
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install necessary tools using DISM
RUN dism.exe /online /enable-feature /all /featurename:NetFx3

# Download and install Office Deployment Tool
ADD https://download.microsoft.com/download/2/9/8/2988E6A6-0E6A-4E7E-8A3E-1D3E8D3E8D3E/OfficeDeploymentTool.exe C:\\OfficeDeploymentTool.exe
RUN C:\\OfficeDeploymentTool.exe /quiet /extract:C:\\Office

# Add configuration files for Office installation
COPY download-config.xml C:\\Office\\download-config.xml
COPY install-config.xml C:\\Office\\install-config.xml

# Install Office including Outlook
RUN C:\\Office\\setup.exe /configure C:\\Office\\install-config.xml


# Install necessary tools
RUN powershell -Command \
    Install-WindowsFeature -Name Web-Server

# Download and install Office Deployment Tool
ADD https://download.microsoft.com/download/2/9/8/2988E6A6-0E6A-4E7E-8A3E-1D3E8D3E8D3E/OfficeDeploymentTool.exe C:\\OfficeDeploymentTool.exe
RUN C:\\OfficeDeploymentTool.exe /quiet /extract:C:\\Office

# Add configuration files for Office installation
COPY download-config.xml C:\\Office\\download-config.xml
COPY install-config.xml C:\\Office\\install-config.xml

# Install Office including Outlook
RUN C:\\Office\\setup.exe /configure C:\\Office\\install-config.xml