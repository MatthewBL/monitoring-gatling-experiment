# Define Variables
$vmName = "Gatling Simulation" # Name of your VirtualBox VM
$sshUser = "username"  # Username to access your Ubuntu VM
$sshPassword = "password" # Password for the user
$gatlingScripts = @("basic.PetManagementIndividualSimulation", "gold.VademecumIndividualSimulation", "gold.VisitManagementIndividualSimulation", "platinum.ConsultationsManagementIndividualSimulation")
$repeatCount = 10
$plans = @{
    "basic" = @("BASIC", "GOLD", "PLATINUM") # Plans for basic scripts
    "gold" = @("GOLD", "PLATINUM")          # Plans for gold scripts
}

# Function to Start VM
function Start-VM {
    Write-Host "Starting VM: $vmName"
    & VBoxManage startvm $vmName --type headless
    Start-Sleep -Seconds 30 # Wait for the VM to boot up
}

# Function to Initialize Environment using SSH
function Initialize-Environment {
    Write-Host "Initializing environment on VM..."
    $initCommands = @"
cd /media/sf_shared_folder/petclinic-gatling
sh petclinic-launch.sh
sleep 30
sh reset_database.sh
exit
"@
    $initCommand = "ssh $sshUser@192.168.1.137 '$initCommands'"
    Invoke-Expression $initCommand
}

# Function to Run Gatling Script using SSH
function Run-GatlingScript {
    param(
        [string]$scriptName,
        [string]$plan
    )
    Write-Host "Running Gatling Script: $scriptName with plan: $plan"
    $scriptCommands = @"
cd /media/sf_shared_folder/petclinic-gatling
./mvnw gatling:test -Dgatling.simulationClass=petclinic.$scriptName -Dplan=$plan
exit
"@
    $scriptCommand = "ssh $sshUser@192.168.1.137 '$scriptCommands'"
    Invoke-Expression $scriptCommand
}

# Function to Shut Down VM
function Shutdown-VM {
    Write-Host "Shutting down VM: $vmName"
    & VBoxManage controlvm $vmName acpipowerbutton
    Start-Sleep -Seconds 30 # Wait for the VM to shut down
}

# Main Logic
foreach ($script in $gatlingScripts) {
    # Extract the script type (e.g., "basic", "gold", "platinum")
    $scriptType = $script.Split('.')[0]

    # Determine the plans to run based on the script type
    if ($plans.ContainsKey($scriptType)) {
        # Run with each specified plan
        foreach ($plan in $plans[$scriptType]) {
            for ($i = 1; $i -le $repeatCount; $i++) {
                Write-Host "Iteration $i of $repeatCount for script: $script with plan: $plan"
                Start-VM
                Initialize-Environment
                Run-GatlingScript -scriptName $script -plan $plan
                Shutdown-VM
            }
        }
    } else {
        # Run scripts without a specific plan
        for ($i = 1; $i -le $repeatCount; $i++) {
            Write-Host "Iteration $i of $repeatCount for script: $script"
            Start-VM
            Initialize-Environment
            Run-GatlingScript -scriptName $script -plan ""
            Shutdown-VM
        }
    }
}

Write-Host "Automation Completed"
