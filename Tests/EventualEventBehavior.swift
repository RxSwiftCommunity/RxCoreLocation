//
//  EventualEventBehavior.swift
//  RxCoreLocation
//
//  Created by Zsolt Kovacs on 07.10.20.
//  Copyright © 2020 RxCoreLocation. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest
import CoreLocation
@testable import RxCoreLocation

struct EventualEventBehaviorContext<T> {
    let scheduler: TestScheduler
    let observable: Observable<T>
    init(_ scheduler: TestScheduler, _ observable: Observable<T>) {
        self.scheduler = scheduler
        self.observable = observable
    }
}

class EventualEventBehavior<T>: Quick.Behavior<EventualEventBehaviorContext<T>> {
    override class func spec(_ context: @escaping () -> EventualEventBehaviorContext<T>) {
        var scheduler: TestScheduler!
        var observable: Observable<T>!

        beforeEach {
            let cxt = context()
            scheduler = cxt.scheduler
            observable = cxt.observable
        }

        afterEach {
            scheduler = nil
            observable = nil
        }

        describe("Has Events Behavior") {
            it("Actually got the event") {
                SharingScheduler.mock(scheduler: scheduler) {
                    let recorded = scheduler.record(source: observable)
                    scheduler.start()
                    expect(recorded.events.count).toEventually(equal(1))
                }
            }
        }
    }
}

