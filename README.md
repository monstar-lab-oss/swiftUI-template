## iOS Project Template for SwiftUI
[![IDE](https://img.shields.io/badge/Xcode-13-blue.svg)](https://developer.apple.com/xcode/)
[![Language](https://img.shields.io/badge/swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/iOS-13-green.svg)](https://developer.apple.com/ios/)
[![Build Status](https://github.com/monstar-lab-oss/swiftUI-template/actions/workflows/build.yml/badge.svg)](https://github.com/monstar-lab-oss/swiftUI-template/actions/workflows/build.yml)


Project template to jumpstart your next iOS project with integrating best practices and tools.

## Motivation

Everytime we create a new project, we do lots of repeated tasks that kills our effective hours. 
This template will save those hours and help to follow standard project architecture.


## Best Practices
* [Cocoapods integration](https://cocoapods.org)
* [Standard gitignore](https://github.com/github/gitignore/blob/master/Swift.gitignore)
* [Moya](https://github.com/Moya/Moya) for netwoking layer

### Todo
* [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) TCA/Composable Architecture of iOS app using Combine and SwiftUI
* [Gemfile for managing Cocoapods version](https://guides.cocoapods.org/using/a-gemfile.html) 
* [Swiftlint](https://github.com/realm/SwiftLint)
* [Swinject](https://github.com/Swinject/Swinject)
* [Compiler performance profiling flags](https://www.jessesquires.com/blog/measuring-compile-times-xcode9)
* Base classes for handling deeplink, notifications and multiple scheme
* Dev/Staging/Prod app flavours
* Separate build configuration for each flavour

### Supporting Tools
Xcode 12.4 or later and Swift 5.1 or later

### Prerequisites:
* [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html)

Install cookiecutter by runing below terminal command.

```
brew install cookiecutter
```

## Usage

The project template uses Cookiecutter to create your project from it. Run below command to create your project from this template:

```
cookiecutter git@github.com:monstar-lab-oss/swiftUI-template.git
```
Give your desire app name then your company name. Thats it, you should be able to see your app directory created based on this template!
From .github folder edit PULL_REQUEST_TEMPLATE.md file and remove OSS template. Other teamplate can be used in actual project. 
The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.
To install the cocoapod dependencies do the following:

Get Bundler

```
sudo gem install bundler
```

To install the specific cocoapods version run

```
bundle install
```

Then install the pods

```
bundle exec pod install
```
## Build Configurations
The templete used `.xcconfig` and `BuildConfiguration.plist` files to maintain different environments(dev/stg/prod). To know how it is done please follow the [link](https://medium.com/better-programming/how-to-create-development-staging-and-production-configs-in-xcode-ec58b2cc1df4)
## Additional configuration

You will have to manually configure the bundle id of the main target and test target.

## Contributing Code
Please refer to [contributing guidelines](https://github.com/monstar-lab-oss/swiftUI-template/blob/main/CONTRIBUTING.md) before participating.


## Acknowledgments

* [iOS project best practices and tools](https://medium.com/@piotr.gorzelany/ios-project-best-practices-and-tools-c46135b8116d)
* [Dev/Staging/Prod Configs in Xcode](https://medium.com/better-programming/how-to-create-development-staging-and-production-configs-in-xcode-ec58b2cc1df4)
* [iOS Build Management using Custom Build Scheme](https://www.talentica.com/blogs/ios-build-management-using-custom-build-scheme/)
