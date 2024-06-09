# Building with a container
Builds in a container without installing requirements on the local system.
> Note: Windows only for now.

### HIP SDK (rocm)
I did not find a way to download the HIP SDK installer automatically, because the download page requires to accept license conditions. Download the installer manually and place it in directory `docker`. Download page: https://www.amd.com/en/developer/resources/rocm-hub/hip-sdk.html#downloads.

### Build
The script will first build the container image that contains build requirements. Then, stable-diffusion.cpp will be compiled in a container that mounts the local source code.

Build with
```pwsh
./docker/build.ps1 -Acceleration [cuda|rocm]
```
Binaries can be found in `docker/build`.
