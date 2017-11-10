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
    }
}

enum AnyError: Swift.Error {
    case updatesError, deferredUpdatesError, regioneError, beaconError
}
