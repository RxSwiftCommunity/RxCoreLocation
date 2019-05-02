//
//  Helpers.swift
//  RxCoreLocation
//
//  Created by Bob Godwin Obi on 10/29/17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//
import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

func clAuthorizationStatus(_ args: [Any]) throws -> CLAuthorizationEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    guard let rawValue = args[1] as? Int32,
        let status = CLAuthorizationStatus.init(rawValue: rawValue) else {
        throw RxCocoaError.castingError(object: args[1], targetType: CLAuthorizationStatus.self)
    }
    return (manager, status)
}

func clLocationsEvent(_ args: [Any]) throws -> CLLocationsEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let locations = try castOrThrow(Array<CLLocation>.self, args[1])
    return (manager, locations)
}
 #if os(iOS) || os(macOS)
func clHeadingEvent(_ args: [Any]) throws -> CLHeadingEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let heading = try castOrThrow(CLHeading.self, args[1])
    return (manager, heading)
}
 #endif
func clRegionEvent(_ args: [Any], _ state: CLRegionEventState) throws -> CLRegionEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let region = try castOrThrow(CLRegion.self, args[1])
    return (manager, region, state)
}
 #if os(iOS) || os(macOS)
func clRegionStateEvent(_ args: [Any]) throws -> CLRegionStateEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let region = try castOrThrow(CLRegion.self, args[2])
    guard let rawValue = args[1] as? Int,
        let state = CLRegionState.init(rawValue: rawValue) else {
        throw RxCocoaError.castingError(object: args[1], targetType: CLRegionState.self)
    }
    return (manager, state, region)
}
#endif

func clErrorEvent(_ args: [Any]) throws ->  CLErrorEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let error = try castOrThrow(Error.self, args[1])
    return (manager, error)
}

#if os(iOS)
func clBeaconsEvent(_ args: [Any]) throws -> CLBeaconsEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let beacons = try castOrThrow(Array<CLBeacon>.self, args[1])
    let region = try castOrThrow(CLBeaconRegion.self, args[2])
    return (manager, beacons, region)
}
    
func clVisitEvent(_ args: [Any]) throws -> CLVisitEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let visit = try castOrThrow(CLVisit.self, args[1])
    return (manager, visit)
}

func clBeaconsErrorEvent(_ args: [Any]) throws -> CLBeaconsErrorEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let beaconRegion = try castOrThrow(CLBeaconRegion.self, args[1])
    let error = try castOrThrow(Error.self, args[2])
    return (manager, beaconRegion, error)
}
#endif

func clRegionErrorEvent(_ args: [Any]) throws -> CLRegionErrorEvent {
    let manager = try castOrThrow(CLLocationManager.self, args[0])
    let region = try castOrThrow(CLRegion.self, args[1])
    let error = try castOrThrow(Error.self, args[2])
    return (manager, region, error)
}

extension ObservableType {
    func map<R>(to value: R) -> Observable<R> {
        return map {_ in value}
    }
    
    func unwrap<T>() -> Observable<T> where Element == Optional<T> {
        return self.filter { $0 != nil }.map { $0! }
    }
}
