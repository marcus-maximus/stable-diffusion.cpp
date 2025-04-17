FROM mcr.microsoft.com/windows/servercore:ltsc2022

SHELL [ "powershell", "-Command" ]

RUN Set-ExecutionPolicy RemoteSigned -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

RUN choco install -y cmake --installargs "ADD_CMAKE_TO_PATH=System"; \
    choco install -y ninja; \
    choco install -y StrawberryPerl

ADD https://aka.ms/vs/17/release/vs_buildtools.exe vs_buildtools.exe
RUN ./vs_buildtools.exe --quiet --wait --norestart --nocache --add 'Microsoft.VisualStudio.Workload.VCTools;includeRecommended'; \
    Remove-Item vs_buildtools.exe -Force

COPY AMD-Software-PRO-Edition-24.Q4-WinSvr2022-For-HIP.exe ./hip_installer.exe
RUN Start-Process hip_installer.exe -NoNewWindow -Wait -ArgumentList '"-install -log hip_install_log.txt"'; \
    Remove-Item hip_installer.exe

RUN choco install -y cuda

WORKDIR C:/sd_cpp
CMD ["powershell"]