[CmdletBinding()]
Param(
   [string]$User = "vsts",
   [string]$Token = "uvtaapt2c24ebecgk5setttkhuqhitmshsjwywxtcshaawl64ntq",
   [string]$FeedURL = "https://feeds.dev.azure.com/adf-darwin/",
   [string]$FeedID = "cf10b1f8-5e11-43a0-90ea-585008a84927",
   [string]$BuildDefinitionName = "Main.Axa.Darwin.IO.Storage.Develop",
   [string]$PackageName = "Agdf.Web.Client.Configuration",
   [string]$PackageURI = "$($FeedURL)_apis/Packaging/Feeds/$FeedID/Packages?packageNameQuery=$PackageName&api-version=5.1-preview.1",
   [string]$ChangeType = "Fix",
   [string]$PreReleaseChangeType = "pre",
   [string]$AssemblyVersion = "",
   [string]$VersionVar = "Axa.Version",
   [string]$ForceVersionVar = ""
)



function Get-LatestVersion($PackageCheck)
{

    $PackageData = $PackageCheck | Where-Object {$_.Name.toLower() -eq $PackageName.ToLower()} | Select-Object Name, ID, Versions

    $PackageName = $PackageData | % Name
    Write-Host "Package name used: $PackageName"

    $PackageID = $PackageData | % ID
    Write-Host "Package id used: $PackageID"

    $PackageVersions = $PackageData | % Versions
    $PackageVersion = $PackageVersions.version
    Write-Host "Package version used: $PackageVersion"

    $PackageVersionsURI = "$FeedURL/_apis/Packaging/Feeds/$FeedID/Packages/$PackageID/versions?api-version=5.1-preview.1"
    $PackageVersionsResult = Invoke-RestMethod -Uri $PackageVersionsURI -Method Get -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}   

    Write-Host "Available versions are:"

    foreach ($PackageVersionItem in $PackageVersionsResult.value)
    {
        Write-Host $PackageVersionItem.Version
    }

    $LatestPackage = $PackageVersionsResult.value[0]
    $isLatest = $LatestPackage.isLatest
    if($isLatest -eq $false)
    {
        if($LatestPackage.isDeleted -eq $true)
        {
            Write-Host "The version $($LatestPackage.Version) of $PackageName has been deleted. It cannot be restored or pushed. (DevOps Activity ID: 2CAB8248-6CF0-49FB-BAC2-6E465D33D405))"
            
            $PackageVersion = $PackageVersionsResult.value[0].Version

            Write-Host "Upgrading deleted version: $PackageVersion"
        }
    }
    else
    {
        
        $PackageVersion = $PackageVersionsResult.value[0].Version
        Write-Host "Taking latest version: $PackageVersion"
    }

    if($ForceVersionVar -match "\d+\.\d+\.\d+")
    {
        if($PackageVersionsResult.value.Version -match "^$ForceVersionVar$")
        {
            throw "Override version needs to be unique. Package $ForceVersionVar already pushed"
        }
        else
        {
            Write-Host "Forcing version: $ForceVersionVar"
            $NewPackageVersion = $ForceVersionVar
        }
    }
    else
    {
    
        $PackageName = $BuildDefinitionName.Split(".") | select -Skip 1 | select -SkipLast 1
        $PackageName = $PackageName -join "."
        
        #$PackageName = "Main.Agdf.Domain.CarE.Resources.Mappers.Develop"
        #$PackageName = $PackageName.Replace("Main.","").Replace(".Develop","")
        
        #$PackageVersion = "0.7.4"
        
        # Split package version string
        
        $V, $S = $PackageVersion.Split('-',2, [System.StringSplitOptions]::RemoveEmptyEntries)
        
        $V = [System.Version]($V)
        
        switch ($ChangeType) {
            'Fix' {
        
                Write-Host "Change type used: $ChangeType"
        
                if($PackageVersion -match $PreReleaseChangeType)
                {
                    $Prefix = "$($V.Major).$($V.Minor).$($V.Build)"
                    $Suffix = $S.Replace($PreReleaseChangeType,"")
                    [int]$Suffix = $Suffix
                    $NewPackageVersion = "$Prefix-$PreReleaseChangeType$([String]::Format("{0:D3}" -f ($Suffix+=1)))"
                   
                    Write-Host "Version genererated: $NewPackageVersion"
                }
                else
                {
                    $Prefix = "$($V.Major).$($V.Minor).$($V.Build + 1)"
                    $NewPackageVersion = "$Prefix-$($PreReleaseChangeType)001"
                   
                    Write-Host "Version genererated: $NewPackageVersion"
                }
            }
            'Feature' {
        
                Write-Host "Change type used: $ChangeType"
        
                $Prefix = "$($V.Major).$($V.Minor + 1).0"
                $NewPackageVersion = "$Prefix-$($PreReleaseChangeType)001"
               
                Write-Host "Version genererated: $NewPackageVersion"
            
            }
            'Breaking' {
        
                Write-Host "Change type used: $ChangeType"
        
                $Prefix = "$($V.Major + 1).0.0"
                $NewPackageVersion = "$Prefix-$($PreReleaseChangeType)001"
               
                Write-Host "Version genererated: $NewPackageVersion"
            
            }
            'Release' {
        
                Write-Host "Change type used: $ChangeType"
        
                $Prefix = "$($V.Major).$($V.Minor).$($V.Build)"
                $NewPackageVersion = $Prefix
          
                Write-Host "Version genererated: $NewPackageVersion"
            
            }
            default {throw "Unsupported change type specified: $ChangeType"}
        }
    }
    return $NewPackageVersion
}

function Set-NewPackageVersion($ForceVersionVar)
{
    Write-Debug "No packages found"

    if([string]::IsNullOrEmpty($ForceVersionVar)){
        Write-Error "This is a new package - Version Override is Mandatory!"
        exit
    }
    else{
        Write-Debug "Override set"

        $NewPackageVersion = $ForceVersionVar
        Write-Host "New package. Setting default version to $NewPackageVersion"

    }
   
    return $NewPackageVersion
    
}

# Base64-encodes the Personal Access Token (PAT) appropriately

$Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User,$Token)))

# Get process list

$PackageResult = Invoke-RestMethod -Uri $PackageURI -Method Get -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $Base64AuthInfo)}

$PackageCheck = $PackageResult.value

if ("" -eq $PackageCheck)
{
    $NewPackageVersion = Set-NewPackageVersion -ForceVersionVar $ForceVersionVar
    Write-Debug "returned newPackageVersion is: $NewPackageVersion"
}
elseif($PackageCheck.name.toLower() -eq $PackageName.ToLower() )
{
    $NewPackageVersion = Get-LatestVersion -PackageCheck $PackageCheck
    Write-Debug "returned newPackageVersion is: $NewPackageVersion"
}
else
{
    $NewPackageVersion = Set-NewPackageVersion -ForceVersionVar $ForceVersionVar
    Write-Debug "returned newPackageVersion is: $NewPackageVersion"
}


if ($NewPackageVersion) {

    $V, $S = $NewPackageVersion.Split('-',2, [System.StringSplitOptions]::RemoveEmptyEntries)
    $AssemblyVersion = $V
    Write-Host "Setting variable: AssemblyVersion = $($AssemblyVersion)"
    "##vso[task.setvariable variable=AssemblyVersion;]$($AssemblyVersion)"
    
    Write-Host "Setting variable: $VersionVar = $($NewPackageVersion)"
    
    "##vso[task.setvariable variable=$VersionVar;]$($NewPackageVersion)"
    
    Write-Host "Updating build number: $($NewPackageVersion)"
    "##vso[build.updatebuildnumber]$($NewPackageVersion)"
}