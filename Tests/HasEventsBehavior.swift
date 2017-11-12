//
//  HasEventsBehavior.swift
//  RxCoreLocation
//
//  Created by Bob Obi on 10.11.17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest
import CoreLocation
@testable import RxCoreLocation

struct HasEventsBehaviorContext<T> {
    let scheduler: TestScheduler
    let observable: Observable<T>
    init(_ scheduler: TestScheduler, _ observable: Observable<T>) {
        self.scheduler = scheduler
        self.observable = observable
    }
}

class HasEventsBehavior<T>: Quick.Behavior<HasEventsBehaviorContext<T>> {
    override class func spec(_ context: @escaping () -> HasEventsBehaviorContext<T>) {
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
                    expect(recorded.events.count) == 1
                }
            }
        }
    }
}

