//
//  CLGeocoderEvents+Rx.swift
//  RxCoreLocation
//
//  Created by Zsolt Kovacs on 18.09.20.
//  Copyright © 2020 RxCoreLocation. All rights reserved.
//

import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

extension Reactive where Base: CLGeocoder {
    /// Reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:completionHandler:)`
    /// used to search for placemark
    public func placemark(with location: CLLocation) -> Observable<CLPlacemark> {
        return Observable.create { [base] observer in
            base.reverseGeocodeLocation(location) { placemarks, _ in
                observer.onNext(placemarks?.first)
            }
            return Disposables.create {
                observer.onCompleted()
            }
        }.unwrap()
    }

    /// Reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:preferredLocale:completionHandler:)`
    /// used to search for placemark
    @available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *)
    public func placemark(with location: CLLocation, preferredLocale: Locale) -> Observable<CLPlacemark> {
        return Observable.create { [base] observer in
            base.reverseGeocodeLocation(location, preferredLocale: preferredLocale) { placemarks, _ in
                observer.onNext(placemarks?.first)
            }
            return Disposables.create {
                observer.onCompleted()
            }
        }.unwrap()
    }
}
