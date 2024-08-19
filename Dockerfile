# Use a specific Windows Server Core base image
# FROM mcr.microsoft.com/windows:ltsc2019
FROM mcr.microsoft.com/windows:1903 AS build
WORKDIR C:\\odtsetup
ADD https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_17830-20162.exe odtsetup.exe
RUN odtsetup.exe /quiet /norestart /extract:C:\\odtsetup
FROM mcr.microsoft.com/windows:1903 AS download
WORKDIR C:\\odtsetup
COPY --from=build C:\\odtsetup\\setup.exe .
ADD config.xml .
RUN setup.exe /download C:\\odtsetup\\config.xml
FROM mcr.microsoft.com/windows:1903
WORKDIR C:\\odtsetup
COPY --from=build C:\\odtsetup\\setup.exe .
COPY --from=download C:\\odtsetup\\Office .
ADD config.xml .
RUN setup.exe /configure C:\\odtsetup\\config.xml
WORKDIR /
RUN rmdir /s /q C:\\odtsetup
# https://stackoverflow.com/questions/10837437/interop-word-documents-open-is-null
RUN powershell -Command new-object -comobject word.application
RUN mkdir C:\\Windows\\SysWOW64\\config\\systemprofile\\Desktop
VOLUME C:\\data