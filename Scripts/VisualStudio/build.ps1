param(
    [Alias("Config")]
    [string]$Configuration = "Debug"
)

# find all .sln files
# excluding:
#   - top level sln,
#   - vulkan_interop: needs additional dependencies
Write-Host "Working Directory: $(Get-Location)"
$slnFiles = Get-ChildItem -Path . -Recurse -Filter "*.sln" -Name -Exclude @("ROCm-Examples*", "vulkan_interop*")

foreach ($file in $slnFiles) {
    Write-Host "===================================================================================================="
    Write-Host "Building Solution: $file"

    $build_cmd = "msbuild -maxCpuCount -property:""Configuration=$Configuration;Platform=x64"" -target:""Build;Clean"" $file"
    Write-Host "Command: $build_cmd"
    Invoke-Expression $build_cmd
}
Write-Host "===================================================================================================="
