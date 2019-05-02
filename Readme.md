## RxCoreLocation

[![Platforms](https://img.shields.io/cocoapods/p/RxCoreLocation.svg)](https://cocoapods.org/pods/RxCoreLocation)
[![License](https://img.shields.io/cocoapods/l/RxCoreLocation.svg)](https://raw.githubusercontent.com/RxSwiftCommunity/RxCoreLocation/master/LICENSE)

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/RxCoreLocation.svg)](https://cocoapods.org/pods/RxCoreLocation)

[![Travis](https://img.shields.io/travis/RxSwiftCommunity/RxCoreLocation/master.svg)](https://travis-ci.org/RxSwiftCommunity/RxCoreLocation/branches)
[![JetpackSwift](https://img.shields.io/badge/JetpackSwift-framework-red.svg)](http://github.com/JetpackSwift/Framework)

RxCoreLocation abstract the Rx behavior for Core Location

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 9.0+ / Mac OS X 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.1+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate RxCoreLocation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'RxCoreLocation', '~> 1.4'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate RxCoreLocation into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "RxSwiftCommunity/RxCoreLocation" ~> 1.4
```
### Swift Package Manager

To use RxCoreLocation as a [Swift Package Manager](https://swift.org/package-manager/) package just add the following in your Package.swift file.

``` swift
import PackageDescription

let package = Package(
    name: "HelloRxCoreLocation",
    dependencies: [
        .Package(url: "https://github.com/RxSwiftCommunity/RxCoreLocation.git", "1.4")
    ]
)
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate RxCoreLocation into your project manually.

#### Git Submodules

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add RxCoreLocation as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/RxSwiftCommunity/RxCoreLocation.git
$ git submodule update --init --recursive
```

- Open the new `RxCoreLocation` folder, and drag the `RxCoreLocation.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `RxCoreLocation.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `RxCoreLocation.xcodeproj` folders each with two different versions of the `RxCoreLocation.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from.

- Select the `RxCoreLocation.framework`.

- And that's it!

> The `RxCoreLocation.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

#### Embeded Binaries

- Download the latest release from https://github.com/RxSwiftCommunity/RxCoreLocation/releases
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Add the downloaded `RxCoreLocation.framework`.
- And that's it!

## Usage
[RxCoreLocation](https://github.com/RxSwiftCommunity/RxCoreLocation) exposes lots of  [Apple Core Location](https://developer.apple.com/documentation/corelocation)  `API` for you to use directly inside your  App.

-  Subscribing for a `CLPlacemark`
```swift

    /// Setup CLLocationManager
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
    
    manager.rx
    .placemark
    .subscribe(onNext: { placemark in
        guard let name = placemark.name,
            let isoCountryCode = placemark.isoCountryCode,
            let country = placemark.country,
            let postalCode = placemark.postalCode,
            let locality = placemark.locality,
            let subLocality = placemark.subLocality else {
                return print("oops it looks like your placemark could not be computed")
        }
        print("name: \(name)")
        print("isoCountryCode: \(isoCountryCode)")
        print("country: \(country)")
        print("postalCode: \(postalCode)")
        print("locality: \(locality)")
        print("subLocality: \(subLocality)")
    })
    .disposed(by: bag)
```
-  You can also subscribe for  a single `CLLocation`  update or for `[CLLocation]` 
```swift

    ///Subscribing for a single location events
    manager.rx
    .location
    .subscribe(onNext: { location in
        guard let location = location else { return }
        print("altitude: \(location.altitude)")
        print("latitude: \(location.coordinate.latitude)")
        print("longitude: \(location.coordinate.longitude)")
    })
    .disposed(by: bag)
    
    ///Subscribing for an array of location events
    manager.rx
    .didUpdateLocations
    .subscribe(onNext: { _, locations in
        guard !locations.isEmpty,
            let currentLocation = locations.last else { return }
            print("altitude: \(currentLocation.altitude)")
            print("latitude: \(currentLocation.coordinate.latitude)")
            print("longitude: \(currentLocation.coordinate.longitude)")
    })
    .disposed(by: bag)
```

- Observing the  `CLAuthorizationStatus`  and reacting based on your needs

```swift

    ///Monitoring authorization changes
    
    manager.rx
    .didChangeAuthorization
    .subscribe(onNext: {_, status in
        switch status {
        case .denied:
            print("Authorization denied")
        case .notDetermined:
            print("Authorization: not determined")
        case .restricted:
            print("Authorization: restricted")
        case .authorizedAlways, .authorizedWhenInUse:
            print("All good fire request")
        }
    })
    .disposed(by: bag)
```
## License

RxCoreLocation is released under the MIT license. See [LICENSE](https://github.com/RxSwiftCommunity/RxCoreLocation/blob/master/LICENSE) for details.
![Try me](https://media.giphy.com/media/d2jjuAZzDSVLZ5kI/giphy.gif)
