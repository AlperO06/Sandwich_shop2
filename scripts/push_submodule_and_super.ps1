param(
    [string]$Message = $(Read-Host 'Enter commit message for the sub-repo (press Enter to skip commit)'),
    [string]$SuperMessage = ''
)

# Determine repository root (script is in project/scripts)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$root = Resolve-Path (Join-Path $scriptDir "..")
$sub = Join-Path $root "sandwich_shop"

Write-Host "Project root: $root"
Write-Host "Sub-repo: $sub"

function Run-Git {
    param($args)
    & git -C $args
}

# Get current branch of sub-repo
$branch = (git -C $sub rev-parse --abbrev-ref HEAD) -replace "\r|\n",""
Write-Host "Sub-repo branch: $branch"

# Commit in sub-repo if there are changes and a message was provided
$subStatus = git -C $sub status --porcelain
if ($subStatus) {
    if (-not $Message) {
        $Message = Read-Host 'Uncommitted changes found. Enter commit message for sub-repo'
    }
    if ($Message) {
        git -C $sub add -A
        git -C $sub commit -m $Message
    } else {
        Write-Host "Skipping commit in sub-repo because no message provided."
    }
} else {
    Write-Host "No working-tree changes in sub-repo."
}

# Always attempt to push the branch (this will also push if local is ahead)
Write-Host "Pushing sub-repo branch '$branch' to origin..."
git -C $sub push origin $branch

# Update superproject pointer and commit if needed
Push-Location $root
try {
    git add sandwich_shop
    $superStatus = git status --porcelain
    if ($superStatus) {
        if (-not $SuperMessage) { $SuperMessage = "Update submodule pointer for sandwich_shop: $Message" }
        git commit -m $SuperMessage
        Write-Host "Pushing superproject 'main' to origin..."
        git push origin main
    } else {
        Write-Host "Superproject has no changes to commit."
    }
} finally {
    Pop-Location
}

Write-Host "Done."
