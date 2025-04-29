FROM mcr.microsoft.com/windows/servercore:ltsc2022

SHELL [ "powershell", "-Command" ]

ADD https://aka.ms/vs/17/release/vs_buildtools.exe vs_buildtools.exe
RUN ./vs_buildtools.exe --quiet --wait --norestart --nocache --add 'Microsoft.VisualStudio.Workload.VCTools;includeRecommended'; \
    Remove-Item vs_buildtools.exe -Force

RUN Set-ExecutionPolicy RemoteSigned -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

RUN choco install -y cmake --installargs "ADD_CMAKE_TO_PATH=System"; \
    choco install -y ninja; \
    choco install -y git

ADD https://developer.download.nvidia.com/compute/cuda/12.8.1/network_installers/cuda_12.8.1_windows_network.exe cuda_installer.exe
RUN Start-Process cuda_installer.exe -NoNewWindow -Wait -ArgumentList '"-s -n cudart_12.8 cublas_12.8 nvcc_12.8"'; \
    Remove-Item cuda_installer.exe

WORKDIR C:/sd_cpp
CMD ["powershell"]