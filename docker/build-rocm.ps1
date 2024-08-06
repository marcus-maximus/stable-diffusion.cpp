$rocMDir = "C:/Program Files/AMD/ROCm/6.1"

$env:PATH += ";$rocMDir/bin"
$env:PATH += ";C:/Strawberry/perl/bin"

cmake -S source -B build -G "Ninja" `
    -D CMAKE_BUILD_TYPE=Release `
    -D CMAKE_C_COMPILER=clang `
    -D CMAKE_CXX_COMPILER=clang++ `
    -D SD_HIPBLAS=ON `
    -D SD_FLASH_ATTN=ON `
    -D AMDGPU_TARGETS="gfx1100;gfx1102;gfx1030"
cmake --build build --config Release --parallel

Copy-Item "$rocMDir/bin/hipblas.dll" ./build/bin
Copy-Item "$rocMDir/bin/rocblas.dll" ./build/bin
Copy-Item -Recurse "$rocMDir/bin/rocblas/library" ./build/bin