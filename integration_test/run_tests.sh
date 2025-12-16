#!/bin/bash
# Script to run integration tests for Sandwich Shop App

echo "Running Sandwich Shop Integration Tests..."
echo "==========================================="
echo ""

# Check if flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "Error: Flutter is not installed or not in PATH"
    exit 1
fi

# Run integration tests
echo "Starting integration test suite..."
flutter test integration_test/app_test.dart

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Integration tests completed successfully!"
else
    echo ""
    echo "✗ Integration tests failed!"
    exit 1
fi
