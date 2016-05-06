#some sample usage of xRobocopy module to sync folders
#for all possible options please refer to robocopy documentation https://technet.microsoft.com/en-us/library/cc733145.aspx

configuration RobocopyExample
{
    Import-DscResource -ModuleName xRobocopy
    Node 'localhost'
    {
        
        LocalConfigurationManager
        {
            #this option should only be used during testing, remove it in production environment
            DebugMode = 'ForceModuleImport'
        }

        #this will copy all files in root, subfolders are ignored
        xRobocopy CopyAllFilesInRoot
        {
            Source = 'C:\temp\source'
            Destination = 'C:\temp\destination'
        }

        #other common use cases, uncomment one at time and comment above one to test them out 
        <# 
        #this will copy only sql files in root directory, subfolders are ignored
        xRobocopy CopyByUsingFilesFilter
        {
            Source = 'C:\temp\source'
            Destination = 'C:\temp\destination'
            Files = '*.sql'
        }

        #this is equivalent of using /e option
        xRobocopy CopyFilesAndSubfolders
        {
            Source = 'C:\temp\source'
            Destination = 'C:\temp\destination'
            SubdirectoriesIncludingEmpty = $true
        }

        #this will sync folders and all subfolders will remove any folders/files not in source
        xRobocopy SyncFolders
        {
            Source = 'C:\temp\source'
            Destination = 'C:\temp\destination'
            AdditionalArgs = '/mir'
        }
        #>
    }
}

RobocopyExample
Set-DscLocalConfigurationManager .\RobocopyExample -Force -Verbose #only needed if using DebugMode
Start-DscConfiguration .\RobocopyExample -Wait -Force -Verbose
