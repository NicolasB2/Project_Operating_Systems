



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
    Write-Host "Press X to exit."
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
    Write-Output "4"
    Read-Host "Press enter to continue"
}

function optionFive
{
    Write-Output "5"
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

