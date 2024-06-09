param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("rocm", "cuda")]
    [string]
    $Acceleration
)

docker build -t sd-cpp -f $PSScriptRoot/win.Dockerfile $PSScriptRoot

if (!(Test-Path $PSScriptRoot/build)) {
    mkdir $PSScriptRoot/build
}

docker run --rm `
    -v $PSScriptRoot/..:C:/sd_cpp/source `
    -v $PSScriptRoot/build:c:/sd_cpp/build sd-cpp `
    powershell -File source/docker/build-${Acceleration}.ps1
