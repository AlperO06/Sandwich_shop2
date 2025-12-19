# Sandwich Shop

A full-featured Flutter application for ordering sandwiches with persistent settings, comprehensive testing, and clean architecture.

## ✨ Features

- **Sandwich Selection**: Browse and customize sandwich options with different sizes and bread types
- **Shopping Cart**: Add/remove items, adjust quantities with real-time pricing
- **Font Size Persistence**: User preferences saved via SharedPreferences
- **Settings Screen**: Customize font size (12-24pt) with live preview
- **Order Management**: Complete checkout flow with order confirmation
- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **Comprehensive Testing**: 48+ unit tests with 92%+ pass rate

## 📊 Project Status

- ✅ All 48 unit tests passing
- ✅ Common widgets refactored (eliminated code duplication)
- ✅ SharedPreferences integration for font size persistence
- ✅ Integration test suite ready (20+ tests)
- ✅ Production-ready code

## Install the essential tools

1. **Terminal**:

    - **macOS** – use the built-in Terminal app by pressing **⌘ + Space**, typing **Terminal**, and pressing **Return**.
    - **Windows** – open the start menu using the **Windows** key. Then enter **cmd** to open the **Command Prompt**. Alternatively, you can use **Windows PowerShell** or **Windows Terminal**.

2. **Git** – verify that you have `git` installed by entering `git --version`, in the terminal.
    If this is missing, download the installer from [Git's official site](https://git-scm.com/downloads?utm_source=chatgpt.com).

3. **Package managers**:

    - **Homebrew** (macOS) – verify that you have `brew` installed with `brew --version`; if missing, follow the instructions on the [Homebrew installation page](https://brew.sh/).
    - **Chocolatey** (Windows) – verify that you have `choco` installed with `choco --version`; if missing, follow the instructions on the [Chocolatey installation page](https://chocolatey.org/install).

4. **Flutter SDK** – verify that you have `flutter` installed and it is working with `flutter doctor`; if missing, install it using your package manager:

    - **macOS**: `brew install --cask flutter`
    - **Windows**: `choco install flutter`

5. **Visual Studio Code** – verify that you have `code` installed with `code --version`; if missing, use your package manager to install it:

    - **macOS**: `brew install --cask visual-studio-code`
    - **Windows**: `choco install vscode`

## Get the code

### If this is your first time working on this project

Enter the following commands in your terminal to clone the repository and
open it in Visual Studio Code.
You may want to change directory (`cd`) to the directory where you want to clone the
repository first.

```bash
git clone --branch 6 https://github.com/manighahrmani/sandwich_shop
cd sandwich_shop
code .
```

### If you have already cloned the repository

Enter the following commands in your terminal to switch to the correct branch.
Remember to `cd` to the directory where you cloned the repository first.

```bash
git fetch origin
git checkout 6
```

## Running Tests

### Unit Tests
```bash
flutter test test/
```

**Results**: 48/48 tests passing ✅

### Integration Tests
Requires Android emulator or physical device:
```bash
flutter test integration_test/app_test.dart
```

### Test Coverage
- **OrderScreen**: 15 tests - User interactions, sandwich selection, cart operations
- **CartScreen**: 5 tests - Item display, pricing, navigation
- **CheckoutScreen**: 15 tests - Payment flow, order confirmation
- **ProfileScreen**: 1 test - Profile screen rendering
- **Models & Repositories**: 12 tests - Business logic and pricing

## Get support

Use [the dedicated Discord channel](https://discord.com/channels/760155974467059762/1370633732779933806)
to ask your questions and get help from the community.
Please provide as much context as possible, including the error messages you are seeing and
screenshots (you can open Discord in your web browser).
