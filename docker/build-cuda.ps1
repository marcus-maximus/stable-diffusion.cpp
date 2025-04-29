& 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\Launch-VsDevShell.ps1' -Arch amd64 -HostArch amd64

cmake -S source -B build -G "Ninja" -D CMAKE_BUILD_TYPE=Release -D SD_CUBLAS=ON
cmake --build build --config Release --parallel

$cudaDir = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
Copy-Item "$cudaDir\bin\cublas64_12.dll" ./build/bin
Copy-Item "$cudaDir\bin\cudart64_12.dll" ./build/bin
Copy-Item "$cudaDir\bin\cublasLt64_12.dll" ./build/bin