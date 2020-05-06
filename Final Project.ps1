



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
    Write-Output "Primero"
    Read-Host "Press enter to continue"
}

function optionTwo
{
    Write-Output "2"
    Read-Host "Press enter to continue"
}

function optionThree
{
    Write-Output "3"
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
        Write-Output $selection
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

