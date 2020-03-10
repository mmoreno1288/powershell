#new ad user script

function nuser {
    function Show-Menu
    {
        param (
            [string]$Title = 'My Menu'
        )
        Clear-Host
        Write-Host "================ $Title ================"
        Write-Host "1: Press '1' for Upland"
        Write-Host "2: Press '2' to Claremont"
        Write-Host "3: Press '3' to District"
    }
     
    function Show-Menu-Upland
    {
        param (
            [string]$Title = 'Upland OUs'
        )
        Clear-Host
        Write-Host "================ $Title ================"
        Write-Host "1: Press '1' for District"
        Write-Host "2: Press '2' for Administration"
        Write-Host "3: Press '3' for Teachers"
        Write-Host "4: Press '4' for International"
        Write-Host "4: Press '5' for Preschool"
    }
    
    function Show-Menu-Claremont
    {
        param (
            [string]$Title = 'Claremont OUs'
        )
        Clear-Host
        Write-Host "================ $Title ================"
        Write-Host "1: Press '1' for Administration"
        Write-Host "2: Press '2' for Daycare"
        Write-Host "3: Press '3' for Elementary"
        Write-Host "4: Press '4' for Middle School"
        Write-Host "5: Press '5' for Office Staff"
        Write-Host "6: Press '6' for PreSchool"
    }
    
    function Show-Menu-District
    {
            param (
            [string]$Title = 'District OUs'
        )
        Clear-Host
        Write-Host "================ $Title ================"
        Write-Host "1: Press '1' for IT"
        Write-Host "2: Press '2' for Maintenance"
        Write-Host "3: Press '3' for Upland"
    }
     
    $Firstname = Read-Host -Prompt 'First Name: '
    $Lastname = Read-Host -Prompt 'Last Name: '
    $Email = Read-Host -Prompt 'Email: '
    $password = Read-Host -Prompt "Password: "
    $pass = ConvertTo-SecureString -String $password -AsPlainText -Force
    $Fullname = "$Firstname $Lastname"
    $firstInitial = $Firstname.Substring(0,1)
    $sam = $firstInitial+$Lastname
    
    
        Show-Menu –Title 'Select OU'
        $input = Read-Host "Select an OU?"
        switch ($input)
        {
            '1' {               
                        Show-Menu-Upland –Title 'Select OU'
                        $input = Read-Host "Select an OU?"
                        switch ($input)
                        {
                            '1' {               
                                    $ou = "OU=District,OU=UPLAND,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '2' {
                                    $ou = "OU=Administration,OU=HIGH SCHOOL,OU=UPLAND,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '3' {
                                    $ou = "OU=TEACHERS,OU=HIGH SCHOOL,OU=UPLAND,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '4' {
                                    $ou = "OU=INTERNATIONAL,OU=UPLAND,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '5' {
                                    $ou = "OU=PRE-SCHOOL,OU=UPLAND,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                        }
                }
            '2' {
                    Show-Menu-Claremont –Title 'Select OU'
                        $input = Read-Host "Select an OU?"
                        switch ($input)
                        {
                            '1' {               
                                    $ou = "OU=ADMINISTRATION,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '2' {
                                    $ou = "OU=DAYCARE,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '3' {
                                    $ou = "OU=ELEMENTARY,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '4' {
                                    $ou = "OU=MIDDLE SCHOOL,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '5' {
                                    $ou = "OU=OFFICE STAFF,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '6' {
                                    $ou = "OU=PRE-SCHOOL,OU=CLAREMONT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                        }
                }
            '3' {
                    Show-Menu-District –Title 'Select OU'
                        $input = Read-Host "Select an OU?"
                        switch ($input)
                        {
                            '1' {               
                                    $ou = "OU=IT DEPT,OU=DISTRICT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '2' {
                                    $ou = "OU=MAINTENANCE,OU=DISTRICT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                            '3' {
                                    $ou = "OU=UPLAND,OU=DISTRICT,OU=WCS - USERS,DC=internal,DC=westernchristian,DC=org"
                                }
                        }
                }
        }
    
    
    New-ADUser $Fullname -samaccountname $sam -DisplayName $Fullname -UserPrincipalName $sam@internal.westernchristian.org -Surname $Lastname -GivenName $Firstname -OtherAttributes @{mail="$Email"} -Enabled 1 -AccountPassword $pass -path $ou
    add-adgroupmember -identity nps-network -members $sam
    }