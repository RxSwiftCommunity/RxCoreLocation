//
//  RxTest+Extension.swift
//  RxCoreLocation
//
//  Created by Bob Obi on 09.11.17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest

extension TestScheduler {
     /// Builds testable observer for s specific observable sequence, binds it's results and sets up disposal.
     /// parameter source: Observable sequence to observe.
     /// returns: Observer that records all events for observable sequence.
    func record<O: ObservableConvertibleType>(source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
}
