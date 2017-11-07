//
//  CLLocationManagerDelegateEvents+Rx.swift
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
/// extension wrapper With Base class `CLLocationManager`
/// Wraps events coming form `CLLocationManagerDelegat`
extension Reactive where Base: CLLocationManager {
    
    /// Reactive wrapper for `CLLocationManagerDelegate`.
    public var delegate: RxCLLocationManagerDelegate {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }

    /// Reactive wrapper for `func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)`
    public var didChangeAuthorization: ControlEvent<CLAuthorizationEvent> {
        let source: Observable<CLAuthorizationEvent> = delegate
            .methodInvoked(.didChangeAuthorization)
            .map(clAuthorizationStatus)
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for `func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])`
    public var didUpdateLocations: ControlEvent<CLLocationsEvent> {
        let source: Observable<CLLocationsEvent> = delegate
            .methodInvoked(.didUpdateLocations)
            .map(clLocationsEvent)
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for: CLErrorEvent
    /// 1. `func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)`
    /// 2. `func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?)`
    public var didError: ControlEvent<CLErrorEvent> {
        let generalError: Observable<CLErrorEvent> = delegate
            .methodInvoked(.didFailWithError)
            .map(clErrorEvent)
        let updatesError: Observable<CLErrorEvent> = delegate
            .methodInvoked(.didFinishDeferredUpdatesWithError)
            .map(clErrorEvent)
        let source = Observable.of(generalError, updatesError).merge()
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for `func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)`
    public var didDetermineState: ControlEvent<CLRegionStateEvent> {
        let source: Observable<CLRegionStateEvent> = delegate
            .methodInvoked(.didDetermineState)
            .map(clRegionStateEvent)
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for: CLRegionEvent
    /// 1. `func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)`
    /// 2. `func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)`
    /// 3. `func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion)`
    public var didReceiveRegion: ControlEvent<CLRegionEvent> {
        let enterRegion: Observable<CLRegionEvent> = delegate
            .methodInvoked(.didEnterRegion)
            .map { try clRegionEvent($0, .enter) }
        
        let exitRegion: Observable<CLRegionEvent> = delegate
            .methodInvoked(.didExitRegion)
            .map { try clRegionEvent($0, .exit) }
        
        let monitoringRegion: Observable<CLRegionEvent> = delegate
            .methodInvoked(.didStartMonitoring)
            .map { try clRegionEvent($0, .monitoring) }
        
        let source = Observable.of(enterRegion, exitRegion, monitoringRegion).merge()
        return ControlEvent(events: source)
    }
}
