function Search-ExcelSharedStrings {
    param (
        [string]$FilePath,
        [string]$Query
    )
    $tempDir = Join-Path $env:TEMP ([Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    try {
        $zipPath = Join-Path $tempDir "temp.zip"
        Copy-Item -Path $FilePath -Destination $zipPath -Force
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        
        $sharedStringsPath = Join-Path $tempDir "xl\sharedStrings.xml"
        if (Test-Path $sharedStringsPath) {
            $content = Get-Content $sharedStringsPath -Raw
            if ($content -match $Query) {
                Write-Output "Found match in $FilePath"
                # Extract surrounding text
                $xml = [xml]$content
                $xml.sst.si | Where-Object { $_.t -match $Query } | ForEach-Object { $_.t }
            }
        }
    } catch {
        Write-Warning "Error processing $FilePath"
    } finally {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

$excelFiles = Get-ChildItem -Path "C:\Users\Naveen Kumar\Downloads" -Filter "*.xlsx" -Recurse -ErrorAction SilentlyContinue
foreach ($file in $excelFiles) {
    Write-Output "Searching in $($file.FullName)..."
    Search-ExcelSharedStrings -FilePath $file.FullName -Query "access"
    Search-ExcelSharedStrings -FilePath $file.FullName -Query "code"
    Search-ExcelSharedStrings -FilePath $file.FullName -Query "token"
}
