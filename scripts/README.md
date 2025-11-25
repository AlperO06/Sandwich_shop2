# Sub-repo push helper

Use the helper script to commit and push changes inside the nested `sandwich_shop` repository, and optionally update the outer repository pointer.

How to run (quick):

- From VS Code: open Command Palette → `Tasks: Run Task` → `Push sub-repo & superproject`.
- From terminal:

```powershell
pwsh .\scripts\push_submodule_and_super.ps1 -Message "Describe sub-repo changes"
```

Notes:
- The script will commit changes found in `sandwich_shop` (it will prompt for a message if none supplied), push that branch to the sub-repo's `origin`, then stage `sandwich_shop` in the superproject and commit/push if the pointer changed.
- If you prefer to commit manually, you can run these commands:

```powershell
git -C .\sandwich_shop add -A
git -C .\sandwich_shop commit -m "Your message"
git -C .\sandwich_shop push origin $(git -C .\sandwich_shop rev-parse --abbrev-ref HEAD)

git add sandwich_shop
git commit -m "Update submodule pointer for sandwich_shop"
git push origin main
```

Troubleshooting:
- If VS Code shows `git: failed to execute git`, restart VS Code after ensuring `git.path` in `.vscode/settings.json` points to your `git.exe` (e.g. `C:\Program Files\Git\cmd\git.exe`).
- Launching VS Code from a terminal (`code .`) ensures it inherits your shell PATH.
