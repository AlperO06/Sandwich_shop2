# Script to run integration tests for Sandwich Shop App (Windows)

Write-Host "Running Sandwich Shop Integration Tests..."
Write-Host "==========================================="
Write-Host ""

# Check if flutter is installed
$flutterPath = where.exe flutter 2>$null
if (-not $flutterPath) {
    Write-Host "Error: Flutter is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Run integration tests
Write-Host "Starting integration test suite..." -ForegroundColor Cyan
flutter test integration_test/app_test.dart

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Integration tests completed successfully!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "✗ Integration tests failed!" -ForegroundColor Red
    exit 1
}
