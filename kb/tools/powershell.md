
## Profile files
- $profile

```powershell
$profile

# create if non existing
test-path $profile
New-Item -Path $profile -Type File -Force
```

## ExecutionPolicy
```powershell
# Check/Set ExecutionPolicy for running the profile
Get-ExecutionPolicy
# Set the ExecutionPolicy to RemoteSigned:
Set-ExecutionPolicy RemoteSigned
```

## Editing script
```powershell
ise <file>

# example for editing user's global script
ise $profile
```

## Info
https://lazyadmin.nl/powershell/powershell-profile/
