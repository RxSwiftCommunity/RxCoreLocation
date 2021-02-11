//
//  CLLocationManagerEvents+Rx.swift
//  RxCoreLocation
//
//  Created by Bob Obi on 08.11.17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

extension Reactive where Base: CLLocationManager {
    /// Reactive Observable for `activityType`
    public var activityType: Observable<CLActivityType?> {
        return self.observe(CLActivityType.self, .activityType)
    }
    /// Reactive Observable for `distanceFilter`
    public var distanceFilter: Observable<CLLocationDistance> {
        return self.observe(CLLocationDistance.self, .distanceFilter)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `desiredAccuracy`
    public var desiredAccuracy: Observable<CLLocationAccuracy> {
        return self.observe(CLLocationAccuracy.self, .desiredAccuracy)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `pausesLocationUpdatesAutomatically`
    public var pausesLocationUpdatesAutomatically: Observable<Bool> {
        return self.observe(Bool.self, .pausesLocationUpdatesAutomatically)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `allowsBackgroundLocationUpdates`
    public var allowsBackgroundLocationUpdates: Observable<Bool> {
        return self.observe(Bool.self, .allowsBackgroundLocationUpdates)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `showsBackgroundLocationIndicator`
    @available(iOS 11.0, *)
    public var showsBackgroundLocationIndicator: Observable<Bool> {
        return self.observe(Bool.self, .showsBackgroundLocationIndicator)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `location`
    public var location: Observable<CLLocation?> {
        let updatedLocation = self.didUpdateLocations.map { $1.last }
        let location =  self.observe(CLLocation.self, .location)
        return Observable.of(location, updatedLocation).merge()
    }
    /// Reactive Observable for CLPlacemark
    public var placemark: Observable<CLPlacemark> {
        return location.unwrap().flatMap(placemark(with:))
    }
    /// Private reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:completionHandler:)`
    /// used to search for placemark
    private func placemark(with location: CLLocation) -> Observable<CLPlacemark> {
        return Observable.create { observer in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, _ in
                observer.onNext(placemarks?.first)
            }
            return Disposables.create {
                observer.onCompleted()
            }
        }.unwrap()
    }

    /// Reactive Observable for CLPlacemark with a given locale
    @available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *)
    public func placemark(preferredLocale: Locale) -> Observable<CLPlacemark> {
        return location.unwrap().flatMap { self.placemark(with: $0, preferredLocale: preferredLocale) }
    }
    /// Private reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:preferredLocale:completionHandler:)`
    /// used to search for placemark
    @available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *)
    private func placemark(with location: CLLocation, preferredLocale: Locale) -> Observable<CLPlacemark> {
        return Observable.create { observer in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: preferredLocale) { placemarks, _ in
                observer.onNext(placemarks?.first)
            }
            return Disposables.create {
                observer.onCompleted()
            }
        }.unwrap()
    }

    /// Reactive Observable for `headingFilter`
    public var headingFilter: Observable<CLLocationDegrees> {
        return self.observe(CLLocationDegrees.self, .headingFilter)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `headingOrientation`
    public var headingOrientation: Observable<CLDeviceOrientation?> {
        return self.observe(CLDeviceOrientation.self, .headingOrientation)
    }
     #if os(iOS) || os(macOS)
    /// Reactive Observable for `heading`
    public var heading: Observable<CLHeading?> {
        return self.observe(CLHeading.self, .heading)
    }
    #endif
    /// Reactive Observable for `maximumRegionMonitoringDistance`
    public var maximumRegionMonitoringDistance: Observable<CLLocationDistance> {
        return self.observe(CLLocationDistance.self, .maximumRegionMonitoringDistance)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `monitoredRegions`
    public var monitoredRegions: Observable<Set<CLRegion>> {
        return self.observe(Set<CLRegion>.self, .monitoredRegions)
            .map { $0 }
            .unwrap()
    }
    /// Reactive Observable for `rangedRegions`
    public var rangedRegions: Observable<Set<CLRegion>> {
        return self.observe(Set<CLRegion>.self, .rangedRegions)
            .map { $0 }
            .unwrap()
    }
    
    /// Reactive Observable for `locationServicesEnabled`
    public var isEnabled: Observable<Bool> {
        return CLLocationManager.__isEnabled.share()
    }
    
    /// Reactive Observable for `authorizationStatus`
    public var status: Observable<CLAuthorizationStatus> {
        return CLLocationManager.__status.share()
    }
    
     #if os(iOS) || os(macOS)
    /// Reactive Observable fo `deferredLocationUpdatesAvailable`
    public var isDeferred: Observable<Bool> {
        return CLLocationManager.__isDeferred.share()
    }
    
    /// Reactive Observable fo `significantLocationChangeMonitoringAvailable`
    public var hasChanges: Observable<Bool> {
        return CLLocationManager.__hasChanges.share()
    }
    
    /// Reactive Observable fo `headingAvailable`
    public var isHeadingAvailable: Observable<Bool> {
        return CLLocationManager.__isHeadingAvailable.share()
    }
    #endif
    /// Reactive Observable fo `isRangingAvailable`
    #if os(iOS)
    public var isRangingAvailable: Observable<Bool> {
        return CLLocationManager.__isRangingAvailable.share()
    }
    #endif
}

extension CLLocationManager {
    /// Reactive Observable for `locationServicesEnabled`
    internal static var __isEnabled: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.locationServicesEnabled()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    /// Reactive Observable for `authorizationStatus`
    internal static var __status: Observable<CLAuthorizationStatus> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.authorizationStatus()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    /// Reactive Observable fo `deferredLocationUpdatesAvailable`
     #if os(iOS) || os(macOS)
    internal static var __isDeferred: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.deferredLocationUpdatesAvailable()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    /// Reactive Observable fo `significantLocationChangeMonitoringAvailable`
    internal static var __hasChanges: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.significantLocationChangeMonitoringAvailable()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    /// Reactive Observable fo `headingAvailable`
    internal static var __isHeadingAvailable: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.headingAvailable()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    #endif
    
    /// Reactive Observable fo `isRangingAvailable`
    #if os(iOS)
    internal static var __isRangingAvailable: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.isRangingAvailable()))
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    #endif
}
