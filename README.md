# Project_Operating_Systems

## Developers:
### - Nicolás Biojo 
### - David Erazo

## Execution:
```powershell 
   Set-ExecutionPolicy Unrestricted 
   Fullpath\DataCenter.ps1
```
## Menu
### 1: Five processes that are consuming the most CPU.
```powershell 
   Get-Process | sort -descending -property CPU | select -First 5
```
### 2: Filesystems or disks connected to the machine.
```powershell 
   Get-WmiObject -Class win32_logicaldisk | ft @{n='Name';e={$_.Name}}, @{n='Free Space (BYTE)';e={$_.FreeSpace}}, @{n='Size (BYTE)';e={$_.Size}}
```
### 3: Name and size of the largest file stored on a disk or filesystem.
```powershell 
    $input =Read-Host "Insert the path of the disk or filesystem"

    Get-ChildItem -Path $input -Recurse | sort -Descending Length | select -First 1 | ft @{n='Name';e={$_.Name}}, @{n='Size (BYTE)';e={$_.Length}}, @{n='Path';e={$_.FullName}}   
```
### 4: Amount of free memory and amount of swap space in use.
```powershell 
   
    $physical = systeminfo | select-string "Memoria f¡sica disponible:"
    $physical_ = [double]([double][regex]::Matches($physical, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "Physical Memory in use (bytes):  "$physical_

    $physical_total = systeminfo | select-string "Cantidad total de memoria f¡sica:"
    $physical_total_ = [double]([double][regex]::Matches($physical_total, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "Physical Memory in use (%):      "(($physical_ / $physical_total_)* 100)" %"

    
    $virtual_use = systeminfo | select-string "Memoria virtual: en uso:"
    $virtual_use_ = [double]([double][regex]::Matches($virtual_use, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "swap Memory in use (bytes):      "$virtual_use_

    $virtual_max = systeminfo | select-string "Memoria virtual: tama¤o m ximo:"
    $virtual_max_ = [double]([double][regex]::Matches($virtual_max, '[\d.]+').Value -replace "\,","")*1000000

    Write-Host "swap Memory in use (%):          "(($virtual_use_ / $virtual_max_)*100)" %"
```
### 5: Number of currently active network connections
```powershell 
    Get-NetTCPConnection -State Established | Measure-Object -Line | ft @{n='Connections';e={$_.Lines}}
```


