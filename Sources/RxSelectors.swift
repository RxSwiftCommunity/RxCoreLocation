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
    
     #if os(iOS) || os(macOS)
    static let didDetermineState = #selector(CLLocationManagerDelegate.locationManager(_:didDetermineState:for:))
    static let didEnterRegion = #selector(CLLocationManagerDelegate.locationManager(_:didEnterRegion:))
    static let didExitRegion = #selector(CLLocationManagerDelegate.locationManager(_:didExitRegion:))
    static let didFinishDeferredUpdatesWithError = #selector(CLLocationManagerDelegate.locationManager(_:didFinishDeferredUpdatesWithError:))
    static let didStartMonitoring = #selector(CLLocationManagerDelegate.locationManager(_:didStartMonitoringFor:))
    static let didFailMonitoring = #selector(CLLocationManagerDelegate.locationManager(_:monitoringDidFailFor:withError:))
    #endif
    
    #if os(iOS)
    static let didRangeBeacons = #selector(CLLocationManagerDelegate.locationManager(_:didRangeBeacons:in:))
    static let didUpdateHeading = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateHeading:))
    static let didVisit = #selector(CLLocationManagerDelegate.locationManager(_:didVisit:))
    static let didPauseLocationUpdates = #selector(CLLocationManagerDelegate.locationManagerDidPauseLocationUpdates(_:))
    static let didResumeLocationUpdates = #selector(CLLocationManagerDelegate.locationManagerDidResumeLocationUpdates(_:))
    static let rangingBeaconsDidFailForRegion = #selector(CLLocationManagerDelegate.locationManager(_:rangingBeaconsDidFailFor:withError:))
    #endif
}
