﻿function Format-CurlyBraces {
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

    # Outline changes to user before proceeding
    # Support /*comment*/

    Get-ChildItem -Path $Path -Recurse `
        | Where-Object { ! $_.PSIsContainer } `
        | ForEach-Object `
        {
            $regex = '([ \t]*)(if[ \t]*\(.*\))[ \t]*(\r\n|\r|\n)*([ \t]*)([^{]*;)'
            $spaceBeforeIf = '`$1' # This is the spacing before the if statement
            $ifStatement = '`$2' # This is the if statement itself
            $newLine = '`$3' # This is the file-specific newline type being used
            $spaceBeforeStatement = '`$4' # This is the spacing before the statement under the if
            $statement = '`$5' # This is the statement under the if
            $regexOutput = "$spaceBeforeIf$ifStatement$newLine$spaceBeforeIf{$newLine$spaceBeforeStatement$statement$newLine$spaceBeforeIf}"
            (Get-Content -Path $_.PSPath -Raw) -replace $regex, $regexOutput `
            | Out-File $_.PSPath
        }
}