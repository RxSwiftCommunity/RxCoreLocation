//
//  RxEventTypealias.swift
//  RxCoreLocation
//
//  Created by Bob Godwin Obi on 10/29/17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import CoreLocation.CLLocationManagerDelegate

///  locationManager:didChangeAuthorizationStatus:
///
///  Discussion:
///    Invoked when the authorization status changes for this application.
public typealias CLAuthorizationEvent = (manager: CLLocationManager, status: CLAuthorizationStatus)
///  locationManager:didUpdateLocations:
///
///  Discussion:
///    Invoked when new locations are available.  Required for delivery of
///    deferred locations.  If implemented, updates will
///    not be delivered to locationManager:didUpdateToLocation:fromLocation:
///
///    locations is an array of CLLocation objects in chronological order.
public typealias CLLocationsEvent = (manager: CLLocationManager, locations: [CLLocation])
///  locationManager:didUpdateHeading:
///
///  Discussion:
///    Invoked when a new heading is available.
 #if os(iOS) || os(macOS)
public typealias CLHeadingEvent = (manager: CLLocationManager, newHeading: CLHeading)
///  locationManager:didDetermineState:forRegion:
///
///  Discussion:
///    Invoked when there's a state transition for a monitored region or in response to a request for state via a
///    a call to requestStateForRegion:.
public typealias CLRegionStateEvent = (manager: CLLocationManager,  state: CLRegionState, region: CLRegion)
#endif
///  locationManager:didRangeBeacons:inRegion:
///
///  Discussion:
///    Invoked when a new set of beacons are available in the specified region.
///    beacons is an array of CLBeacon objects.
///    If beacons is empty, it may be assumed no beacons that match the specified region are nearby.
///    Similarly if a specific beacon no longer appears in beacons, it may be assumed the beacon is no longer received
///    by the device.
#if os(iOS)
public typealias CLBeaconsEvent = (manager: CLLocationManager, beacons: [CLBeacon], region: CLBeaconRegion)
///  locationManager:rangingBeaconsDidFailForRegion:withError:
///
///  Discussion:
///    Invoked when an error has occurred ranging beacons in a region. Error types are defined in "CLError.h".
public typealias CLBeaconsErrorEvent = (manager: CLLocationManager, region: CLBeaconRegion, error: Error)
#endif
///  locationManager:didEnterRegion:
///  locationManager:didExitRegion:
///  locationManager:didStartMonitoringForRegion:
///
///  Discussion:
///    1. Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
///    2. Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
///    3. Invoked when a monitoring for a region started successfully
///    CLLocationManager instance with a non-nil delegate that implements this method.
public typealias CLRegionEvent = (manager: CLLocationManager, region: CLRegion, state: CLRegionEventState)
///  locationManager:didFailWithError:
///  locationManager:didFinishDeferredUpdatesWithError:
///
///  Discussion:
///    1. Invoked when an error has occurred. Error types are defined in "CLError.h".
///    2. Invoked when deferred updates will no longer be delivered. Stopping
///    location, disallowing deferred updates, and meeting a specified criterion
///    are all possible reasons for finishing deferred updates.
public typealias CLErrorEvent = (manager: CLLocationManager, error: Error)
 ///  locationManager:monitoringDidFailForRegion:withError:
 ///
 ///  Discussion:
 ///    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
public typealias CLRegionErrorEvent = (manager: CLLocationManager, region: CLRegion?, error: Error)
///  locationManagerDidPauseLocationUpdates:
///  locationManagerDidResumeLocationUpdates:
///  Discussion:
///    Invoked when location updates are automatically paused.
public typealias CLVoidEvent = Swift.Void
///  locationManager:didVisit:
///
///  Discussion:
///    Invoked when the CLLocationManager determines that the device has visited
///    a location, if visit monitoring is currently started (possibly from a
///    prior launch).
#if os(iOS)
public typealias CLVisitEvent = (manager: CLLocationManager, visit: CLVisit)
#endif
/// CLRegionEventState:
public enum CLRegionEventState {
    case enter, exit, monitoring
}

