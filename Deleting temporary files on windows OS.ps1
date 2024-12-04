# Temporary File Path
$TempUser = "$env:LOCALAPPDATA\Temp"
$TempSystem = "$env:SystemRoot\Temp"

# Function to securely delete files and folders
function Clear-TemporaryFiles {
    param (
        [string]$Path
    )
    Write-Host "Cleaning the folder : $Path" -ForegroundColor Yellow

    # Check if the path exists
    if (Test-Path $Path) {
        try {
            # Delete the files
            Get-ChildItem -Path $Path -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
                Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
            }

            # delete the folders
            Get-ChildItem -Path $Path -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
                Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
            }

            Write-Host "Cleaning completed for : $Path" -ForegroundColor Green
        } catch {
            Write-Host "Error while cleaning : $Path. Message : $_" -ForegroundColor Red
        }
    } else {
        Write-Host "The path $Path doesn't exist." -ForegroundColor Red
    }
}

# Cleaning user and system temporary files
Clear-TemporaryFiles -Path $TempUser
Clear-TemporaryFiles -Path $TempSystem

Write-Host "Cleaning completed for all temporary directories" -ForegroundColor Cyan
