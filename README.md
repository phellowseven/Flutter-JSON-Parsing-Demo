# flutter_json_parsing_demo

A new Flutter project to showcase the parsing issue of big JSON-data between flutter 3.7.0 and flutter 3.7.1.

## Install `fvm`

Documentation: https://fvm.app/docs/getting_started/installation/

**macOS/Linux**

```
brew tap leoafarias/fvm
brew install fvm
```

**Windows**

```
choco install fvm
```

### Uninstall

**macOS/Linux**

```
brew uninstall fvm
brew untap leoafarias/fvm
```

### Pub package

You are able to also install FVM as a pub package.

However if you plan on using FVM to manage your global Flutter install we recommend installing as a standalone.

```
dart pub global activate fvm
```

## Switch Flutter Versions

Start out using v3.7.0 as this is the last one this Issue doesn't occur:

```bash
fvm use 3.7.0
```

If asked to install, confirm.

To switch versions, run:

```bash
fvm use 3.7.1
```

_Note:_ when using VSCode, you may need to reload the window after this command for VSCode to recognize the change. `Command Palette > Developer: Reload Window`

## Run the Flutter app

```bash
fvm flutter pub get # get packages
fvm flutter run # run the app
```

# Reproduce the bug

1. Start out using Flutter version 3.7.0: `fvm use 3.7.0`
2. Get packages: `fmv flutter pub get`
3. Run the app: `fmv flutter run` (When using VSCode to run, be sure to reload the window)
4. The app should display **"IHE XDS classCode by IHE Deutschland e.V."**
5. Stop the app
6. Switch Flutter version to 3.7.1: `fvm use 3.7.1`
7. Get packages: `fmv flutter pub get`
8. Run the app: `fmv flutter run` (When using VSCode to run, be sure to reload the window)
