//
//  RxSelectors.swift
//  RxCoreLocation
//
//  Created by Bob Godwin Obi on 10/28/17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import CoreLocation.CLLocationManagerDelegate

extension Selector {
    static let didChangeAuthorization = #selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:))
    static let didUpdateLocations = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))
    static let didFailWithError = #selector(CLLocationManagerDelegate.locationManager(_:didFailWithError:))
    
    @available(iOS 9.3, macOS 10.11, *)
    static let didDetermineState = #selector(CLLocationManagerDelegate.locationManager(_:didDetermineState:for:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didEnterRegion = #selector(CLLocationManagerDelegate.locationManager(_:didEnterRegion:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didExitRegion = #selector(CLLocationManagerDelegate.locationManager(_:didExitRegion:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didFinishDeferredUpdatesWithError = #selector(CLLocationManagerDelegate.locationManager(_:didFinishDeferredUpdatesWithError:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didRangeBeacons = #selector(CLLocationManagerDelegate.locationManager(_:didRangeBeacons:in:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didStartMonitoring = #selector(CLLocationManagerDelegate.locationManager(_:didStartMonitoringFor:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didFailMonitoring = #selector(CLLocationManagerDelegate.locationManager(_:monitoringDidFailFor:withError:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didUpdateHeading = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateHeading:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didVisit = #selector(CLLocationManagerDelegate.locationManager(_:didVisit:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didPauseLocationUpdates = #selector(CLLocationManagerDelegate.locationManagerDidPauseLocationUpdates(_:))
    @available(iOS 9.3, macOS 10.11, *)
    static let didResumeLocationUpdates = #selector(CLLocationManagerDelegate.locationManagerDidResumeLocationUpdates(_:))
    @available(iOS 9.3, macOS 10.11, *)
    static let rangingBeaconsDidFailForRegion = #selector(CLLocationManagerDelegate.locationManager(_:rangingBeaconsDidFailFor:withError:))
    
}
