Param(

   [string]$User = "vsts",

   [string]$Token = "uvtaapt2c24ebecgk5setttkhuqhitmshsjwywxtcshaawl64ntq",

   [string]$BuildURI = "https://dev.azure.com/adf-darwin/Packages/_apis/build/definitions?api-version=5.1"
)


# Base64-encodes the Personal Access Token (PAT) appropriately

# $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))

# $BuildDefinitionList = Invoke-RestMethod -Uri $BuildURI -Method GET -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

# $BuildDefinitionList.value


$URI = "https://dev.azure.com/adf-darwin/Packages/_apis/build/definitions/694/revisions?api-version=5.1"
$RevisionList = Invoke-RestMethod -Uri $URI -Method GET -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

$RevisionList.value

# #-------------------
