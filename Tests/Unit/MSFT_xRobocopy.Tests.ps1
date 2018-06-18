#region HEADER
# TODO: Update to correct module name and resource name.
$script:DSCModuleName = 'xRobocopy'
$script:DSCResourceName = 'MSFT_xRobocopy'

# Unit Test Template Version: 1.2.2
$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if ( (-not (Test-Path -Path (Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests'))) -or `
     (-not (Test-Path -Path (Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests\TestHelper.psm1'))) )
{
    & git @('clone','https://github.com/PowerShell/DscResource.Tests.git',(Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests'))
}

Import-Module -Name (Join-Path -Path $script:moduleRoot -ChildPath (Join-Path -Path 'DSCResource.Tests' -ChildPath 'TestHelper.psm1')) -Force

# TODO: Insert the correct <ModuleName> and <ResourceName> for your resource
$TestEnvironment = Initialize-TestEnvironment `
    -DSCModuleName $script:DSCModuleName `
    -DSCResourceName $script:DSCResourceName `
    -ResourceType 'Mof' `
    -TestType Unit

#endregion HEADER

function Invoke-TestSetup
{
}

function Invoke-TestCleanup
{
    Restore-TestEnvironment -TestEnvironment $TestEnvironment
}

# Begin Testing
try
{
    Invoke-TestSetup

    InModuleScope $script:DSCResourceName {
        Describe 'MSFT_xRobocopy\Get-RobocopyArguments' -Tag 'Helper' {
            Context 'When only providing source and destination parameters' {
                It 'Should return the correct arguments' {
                    $result = Get-RobocopyArguments -Source 'C:\' -Destination 'D:\'
                    $result.Count | Should -Be 2
                    $result[0] | Should -Be 'C:\'
                    $result[1] | Should -Be 'D:\'
                }
            }
        }
    }
}
finally
{
    Invoke-TestCleanup
}
