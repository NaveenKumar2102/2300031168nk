function Read-ExcelWorkbookStructure {
    param (
        [string]$Path
    )
    $tempDir = Join-Path $env:TEMP ([Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    try {
        $zipPath = Join-Path $tempDir "temp.zip"
        Copy-Item -Path $Path -Destination $zipPath -Force
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        
        $workbookPath = Join-Path $tempDir "xl\workbook.xml"
        if (Test-Path $workbookPath) {
            Write-Output "Workbook structure for $Path`:"
            [xml]$wb = Get-Content $workbookPath -Raw
            $wb.workbook.sheets.sheet | ForEach-Object {
                Write-Output "  Sheet Name: $($_.name) (ID: $($_.sheetId))"
            }
        }
    } catch {
        Write-Warning "Error reading structure: $_"
    } finally {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

$file = "C:\Users\Naveen Kumar\Downloads\Telegram Desktop\Y23 CRT on 30th May 26 (3).xlsx"
if (Test-Path $file) {
    Read-ExcelWorkbookStructure -Path $file
} else {
    Write-Output "File not found"
}
