function Format-CurlyBraces {
    param(
        [ValidateScript({
            if($null -eq $_) {
                throw "You must provide a valid path."
            }
            if(-Not ($_ | Test-Path) ) {
                throw "File or folder does not exist."
            }
            return $true
        })]
        [System.IO.FileInfo]$Path
    )

    Get-ChildItem -Path $Path -Recurse `
        | Where-Object { ! $_.PSIsContainer } `
        | ForEach-Object `
        {
            (Get-Content -Path $_.PSPath -Raw) -replace '([ \t]*)(if[ \t]*\(.*\))[ \t]*(\r\n|\r|\n)*([ \t]*)([^{]*;)', "`$1`$2$([Environment]::NewLine)`$1{$([Environment]::NewLine)`$4`$5$([Environment]::NewLine)`$1}" `
            | Out-File $_.PSPath
        }
}

function Format-DependencyInjectionChecks {
    param(
        [ValidateScript({
            if($null -eq $_) {
                throw "You must provide a valid path."
            }
            if(-Not ($_ | Test-Path) ) {
                throw "File or folder does not exist."
            }
            return $true
        })]
        [System.IO.FileInfo]$Path
    )

    # Existing if null checks or Null coalescing

    $files = Get-ChildItem -Path $Path -Recurse
    Get-ChildItem -Path $Path -Recurse | Where-Object { ! $_.PSIsContainer } `
        | ForEach-Object `
        {
            (Get-Content -Path $_.PSPath -Raw) -replace '([ \t]*)(if[ \t]*\(.*\))[ \t]*(\r\n|\r|\n)*([ \t]*)([^{]*;)', "`$1`$2$([Environment]::NewLine)`$1{$([Environment]::NewLine)`$4`$5$([Environment]::NewLine)`$1}" `
            | Out-File $_.PSPath
        }
    Write-Output 'Finished refactor.'
}

Export-ModuleMember -Function Format-CurlyBraces, Format-DependencyInjectionChecks