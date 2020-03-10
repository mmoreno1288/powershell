$a = 0
$inputOK = $false
do
{
  try
  {
    $a = Read-Host "Please enter the number between 1 and 4"
    if (([int]$a)) {
    $inputOK = $true}
  }
  catch
  {
    Write-Host -ForegroundColor red "INVALID INPUT!  Please enter a numeric value."
  } 

}
until ($inputOK)

Write-Host $a.GetType().Name
$a_int = [int]$a
Write-Host $a_int.GetType().Name
Write-Host –ForegroundColor green "You have entered $a"
