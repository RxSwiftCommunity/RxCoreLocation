//
//  RxCoreLocationSpec.swift
//  RxCoreLocation
//
//  Created by Obi Bob Godwin on 04/10/16.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import Quick
import Nimble
import CoreLocation
import RxSwift
import RxCocoa
import RxTest
@testable import RxCoreLocation

class RxCoreLocationSpec: QuickSpec {

    override func spec() {
        var sut: CLLocationManager!
        var scheduler: TestScheduler!

        beforeEach {
            sut = CLLocationManager()
            scheduler = TestScheduler(initialClock: 0)
        }
         
        afterEach {
            sut = nil
            scheduler = nil
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didChangeAuthorization) {
                sut.delegate?.locationManager!(sut, didChangeAuthorization: CLAuthorizationStatus.authorizedAlways)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didUpdateLocations) {
                let location = CLLocation(latitude: 180, longitude: 90)
                sut.delegate?.locationManager!(sut, didUpdateLocations: [location])
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didFailWithError) {
                sut.delegate?.locationManager!(sut, didFailWithError: AnyError.updatesError)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didDetermineState) {
                let state = CLRegionState.outside
                let region = CLRegion()
                sut.delegate?.locationManager!(sut, didDetermineState: state, for: region)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didEnterRegion) {
                let region = CLRegion()
                sut.delegate?.locationManager!(sut, didEnterRegion: region)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didExitRegion) {
                let region = CLRegion()
                sut.delegate?.locationManager!(sut, didExitRegion: region)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didFinishDeferredUpdatesWithError) {
                sut.delegate?.locationManager!(sut, didFinishDeferredUpdatesWithError: AnyError.deferredUpdatesError)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didRangeBeacons) {
                let beaconRegion = CLBeaconRegion(proximityUUID: UUID.init(), major: 1234, identifier: "0987654321")
                sut.delegate?.locationManager!(sut, didRangeBeacons: [], in: beaconRegion)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didStartMonitoring) {
                sut.delegate?.locationManager!(sut, didStartMonitoringFor: CLRegion())
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didFailMonitoring) {
                sut.delegate?.locationManager!(sut, monitoringDidFailFor: nil, withError: AnyError.regioneError)
            }
        }

        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didUpdateHeading) {
                sut.delegate?.locationManager!(sut, didUpdateHeading: CLHeading())
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didPauseLocationUpdates) {
                sut.delegate?.locationManagerDidPauseLocationUpdates!(sut)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .didResumeLocationUpdates) {
                sut.delegate?.locationManagerDidResumeLocationUpdates!(sut)
            }
        }
        
        itBehavesLike(ForwardsEventsBehavior.self) {
            ForwardsEventsBehaviorContext(sut, scheduler, .rangingBeaconsDidFailForRegion) {
                let beaconRegion = CLBeaconRegion(proximityUUID: UUID.init(), major: 4321, identifier: "10101010101")
                sut.delegate?.locationManager!(sut, rangingBeaconsDidFailFor: beaconRegion, withError: AnyError.beaconError)
            }
        }
        
        itBehavesLike(HasEventsBehavior<CLActivityType?>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.activityType)
        }
        
        itBehavesLike(HasEventsBehavior<CLLocationDistance>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.distanceFilter)
        }
        
        itBehavesLike(HasEventsBehavior<CLLocationAccuracy>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.desiredAccuracy)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.pausesLocationUpdatesAutomatically)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.allowsBackgroundLocationUpdates)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            if #available(iOS 11.0, *) {
                HasEventsBehaviorContext(scheduler, sut.rx.showsBackgroundLocationIndicator)
            }
        }
        
        itBehavesLike(HasEventsBehavior<CLLocation?>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.location)
        }
        
        itBehavesLike(HasEventsBehavior<CLLocationDegrees>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.headingFilter)
        }
        
        itBehavesLike(HasEventsBehavior<CLDeviceOrientation?>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.headingOrientation)
        }
        
        itBehavesLike(HasEventsBehavior<CLHeading?>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.heading)
        }
        
        itBehavesLike(HasEventsBehavior<CLLocationDistance>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.maximumRegionMonitoringDistance)
        }
        
        itBehavesLike(HasEventsBehavior<Set<CLRegion>>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.monitoredRegions)
        }
        
        itBehavesLike(HasEventsBehavior<Set<CLRegion>>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.rangedRegions)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.isEnabled)
        }
        
        itBehavesLike(HasEventsBehavior<CLAuthorizationStatus>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.status)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.isDeferred)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.hasChanges)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.isHeadingAvailable)
        }
        
        itBehavesLike(HasEventsBehavior<Bool>.self) {
            HasEventsBehaviorContext(scheduler, sut.rx.isRangingAvailable)
        }
    }
}

enum AnyError: Swift.Error {
    case updatesError, deferredUpdatesError, regioneError, beaconError
}
