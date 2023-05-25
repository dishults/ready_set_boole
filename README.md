# ready_set_boole
An introduction to Boolean Algebra

To run this project on LInux just install Swift with brew
```shell
brew install swift
```
You can also install a code formatter on both macOS and Linux
```shell
# Install
brew install swift-format
# Use
swift-format --in-place --recursive .
```
Other useful commands
```shell
# Create an executable Swift Package from command line
mkdir NewPackage && cd NewPackage
swift package init --type executable

# Build & run
swift run [executable_name]

# Build -> run
swift build
.build/debug/NewPackage

# REPL with importable custom libraries
cd [swift package]
swift run --repl
import Utils
```
