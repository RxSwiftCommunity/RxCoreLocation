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
        return self.observe(CLActivityType.self, "activityType")
    }
    /// Reactive Observable for `distanceFilter`
    public var distanceFilter: Observable<CLLocationDistance> {
        return self.observe(CLLocationDistance.self, "distanceFilter")
            .map { $0 ?? 0.0 }
    }
    /// Reactive Observable for `desiredAccuracy`
    public var desiredAccuracy: Observable<CLLocationAccuracy> {
        return self.observe(CLLocationAccuracy.self, "desiredAccuracy")
            .map { $0 ?? 0.0 }
    }
    /// Reactive Observable for `pausesLocationUpdatesAutomatically`
    public var pausesLocationUpdatesAutomatically: Observable<Bool> {
        return self.observe(Bool.self, "pausesLocationUpdatesAutomatically")
            .map { $0 ?? false }
    }
    /// Reactive Observable for `allowsBackgroundLocationUpdates`
    public var allowsBackgroundLocationUpdates: Observable<Bool> {
        return self.observe(Bool.self, "allowsBackgroundLocationUpdates")
            .map { $0 ?? false }
    }
    /// Reactive Observable for `showsBackgroundLocationIndicator`
    public var showsBackgroundLocationIndicator: Observable<Bool> {
        return self.observe(Bool.self, "showsBackgroundLocationIndicator")
            .map { $0 ?? false }
    }
    /// Reactive Observable for `location`
    public var location: Observable<CLLocation?> {
        return self.observe(CLLocation.self, "location")
    }
    /// Reactive Observable for `headingFilter`
    public var headingFilter: Observable<CLLocationDegrees> {
        return self.observe(CLLocationDegrees.self, "headingFilter")
            .map { $0 ?? 0.0 }
    }
    /// Reactive Observable for `headingOrientation`
    public var headingOrientation: Observable<CLDeviceOrientation?> {
        return self.observe(CLDeviceOrientation.self, "headingOrientation")
    }
    /// Reactive Observable for `heading`
    public var heading: Observable<CLHeading?> {
        return self.observe(CLHeading.self, "heading")
    }
    /// Reactive Observable for `maximumRegionMonitoringDistance`
    public var maximumRegionMonitoringDistance: Observable<CLLocationDistance> {
        return self.observe(CLLocationDistance.self, "maximumRegionMonitoringDistance")
            .map { $0 ?? 0.0 }
    }
    /// Reactive Observable for `monitoredRegions`
    public var monitoredRegions: Observable<Set<CLRegion>> {
        return self.observe(Set<CLRegion>.self, "monitoredRegions")
            .map { $0 ?? [] }
    }
    /// Reactive Observable for `rangedRegions`
    public var rangedRegions: Observable<Set<CLRegion>> {
        return self.observe(Set<CLRegion>.self, "rangedRegions")
            .map { $0 ?? [] }
    }
    /// Reactive Observable for `locationServicesEnabled`
    public static var isEnabled: Observable<Bool> {
        return Observable.create { observer in
            if CLLocationManager.locationServicesEnabled() {
                observer.on(.next(true))
                observer.onCompleted()
            } else {
                observer.on(.next(false))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    /// Reactive Observable for `authorizationStatus`
    public static var status: Observable<CLAuthorizationStatus> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.authorizationStatus()))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    /// Reactive Observable fo `deferredLocationUpdatesAvailable`
    public static var isDeferred: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.deferredLocationUpdatesAvailable()))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    /// Reactive Observable fo `significantLocationChangeMonitoringAvailable`
    public static var hasChanges: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.significantLocationChangeMonitoringAvailable()))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    /// Reactive Observable fo `headingAvailable`
    public static var isHeadingAvailable: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.headingAvailable()))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    /// Reactive Observable fo `isRangingAvailable`
    public static var isRangingAvailable: Observable<Bool> {
        return Observable.create { observer in
            observer.on(.next(CLLocationManager.isRangingAvailable()))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}


