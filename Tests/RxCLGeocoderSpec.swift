//
//  CLGeocoderSpec.swift
//  RxCoreLocation
//
//  Created by Zsolt Kovacs on 07.10.20.
//  Copyright © 2020 RxCoreLocation. All rights reserved.
//

import Quick
import Nimble
import CoreLocation
import RxSwift
import RxCocoa
import RxTest
@testable import RxCoreLocation

class RxCLGeocoderSpec: QuickSpec {

    override func spec() {
        var sut: CLGeocoder!
        var scheduler: TestScheduler!

        beforeEach {
            sut = CLGeocoder()
            scheduler = TestScheduler(initialClock: 0)
        }

        afterEach {
            sut = nil
            scheduler = nil
        }

        itBehavesLike(EventualEventBehavior<CLPlacemark>.self) {
            let location = CLLocation(latitude: 47.2, longitude: 8.52)
            return EventualEventBehaviorContext(scheduler, sut.rx.placemark(with: location))
        }

        if #available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *) {
            itBehavesLike(EventualEventBehavior<CLPlacemark>.self) {
                let location = CLLocation(latitude: 47.200364, longitude: 8.522604)
                let locale = Locale.current
                return EventualEventBehaviorContext(scheduler, sut.rx.placemark(with: location, preferredLocale: locale))
            }
        }

        itBehavesLike(EventualEventBehavior<[CLPlacemark]>.self) {
            let addressString = "Palais des Nations, 1211 Genève"
            return EventualEventBehaviorContext(scheduler, sut.rx.placemarks(with: addressString))
        }

        itBehavesLike(EventualEventBehavior<[CLPlacemark]>.self) {
            let addressString = "Palais des Nations, 1211 Genève"
            let region = CLCircularRegion(
                center: CLLocationCoordinate2D(latitude: 46.226328, longitude: 6.141381),
                radius: 500,
                identifier: "Geneva region")
            return EventualEventBehaviorContext(scheduler, sut.rx.placemarks(with: addressString, in: region))
        }

        if #available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *) {
            itBehavesLike(EventualEventBehavior<[CLPlacemark]>.self) {
                let addressString = "Palais des Nations, 1211 Genève"
                let region = CLCircularRegion(
                    center: CLLocationCoordinate2D(latitude: 46.226328, longitude: 6.141381),
                    radius: 500,
                    identifier: "Geneva region")
                let locale = Locale.current
                return EventualEventBehaviorContext(scheduler, sut.rx.placemarks(with: addressString, in: region, preferredLocale: locale))
            }
        }
    }
}
