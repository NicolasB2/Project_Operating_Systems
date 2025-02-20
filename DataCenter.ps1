

<#
.SYNOPSIS
This project consists of a tool that provides a series of commands to facilitate the tasks of the administrator of a data center.

.DESCRIPTION
This project contains a menu with the following options:            
1: Five processes that are consuming the most CPU.
2: Filesystems or disks connected to the machine.
3: Name and size of the largest file stored on a disk or filesystem.
4: Amount of free memory and amount of swap space in use.
5: 5: Number of currently active network connections
x: Press X to exit.


.EXAMPLE
press 3 after write a full path
3 -> D: 
#>

function Show-Menu
{
    Clear-Host
    Write-Host "                     Menu of Management                "
    Write-Host 
    Write-Host "1: Five processes that are consuming the most CPU."
    Write-Host
    Write-Host "2: Filesystems or disks connected to the machine."
    Write-Host
    Write-Host "3: Name and size of the largest file stored on a disk or filesystem."
    Write-Host
    Write-Host "4: Amount of free memory and amount of swap space in use."
    Write-Host
    Write-Host "5: Number of currently active network connections"
    Write-Host
    Write-Host "x: Press X to exit."
    Write-Host
}

function optionOne
{
    Get-Process | sort -descending -property CPU | select -First 5
    Read-Host "Press enter to continue"
}

function optionTwo
{
    Get-WmiObject -Class win32_logicaldisk | ft @{n='Name';e={$_.Name}}, @{n='Free Space (BYTE)';e={$_.FreeSpace}}, @{n='Size (BYTE)';e={$_.Size}}
    Read-Host "Press enter to continue"
}

function optionThree
{
    
    $input =Read-Host "Insert the path of the disk or filesystem"

    Get-ChildItem -Path $input -Recurse | sort -Descending Length | select -First 1 | ft @{n='Name';e={$_.Name}}, @{n='Size (BYTE)';e={$_.Length}}, @{n='Path';e={$_.FullName}}
    Read-Host "Press enter to continue"
}

function optionFour
{


    $physical = systeminfo | select-string "Memoria f�sica disponible:"
    $physical_ = [double]([double][regex]::Matches($physical, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "Physical Memory in use (bytes):  "$physical_

    $physical_total = systeminfo | select-string "Cantidad total de memoria f�sica:"
    $physical_total_ = [double]([double][regex]::Matches($physical_total, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "Physical Memory in use (%):      "(($physical_ / $physical_total_)* 100)" %"

    
    $virtual_use = systeminfo | select-string "Memoria virtual: en uso:"
    $virtual_use_ = [double]([double][regex]::Matches($virtual_use, '[\d.]+').Value -replace "\,","")*1000000
    Write-Host "swap Memory in use (bytes):      "$virtual_use_

    $virtual_max = systeminfo | select-string "Memoria virtual: tama�o m�ximo:"
    $virtual_max_ = [double]([double][regex]::Matches($virtual_max, '[\d.]+').Value -replace "\,","")*1000000

    Write-Host "swap Memory in use (%):          "(($virtual_use_ / $virtual_max_)*100)" %"


    Read-Host "Press enter to continue"
    
}

function optionFive
{
    Get-NetTCPConnection -State Established | Measure-Object -Line | ft @{n='Connections';e={$_.Lines}}
    Read-Host "Press enter to continue"
}



$exit=$True

while($exit){
    Show-Menu
    $selection = Read-Host "Choose an option"
    switch($selection)
    {
        '1'{ optionOne }
        '2'{ optionTwo }
        '3'{ optionThree }
        '4'{ optionFour }
        '5'{ optionFive }
        'X'{ $exit=$False}
    }
    
}

