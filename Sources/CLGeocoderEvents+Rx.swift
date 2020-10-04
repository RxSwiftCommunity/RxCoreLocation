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

private extension NSError {
    static var geocoderFoundNoResult: NSError {
        NSError(domain: CLError.errorDomain, code: CLError.geocodeFoundNoResult.rawValue, userInfo: nil)
    }
}

extension Reactive where Base: CLGeocoder {
    /// Reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:completionHandler:)`
    /// used to search for placemark
    public func placemark(with location: CLLocation) -> Observable<CLPlacemark> {
        return Observable.create { [base] observer in
            base.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let placemark = placemarks?.first else {
                    observer.onError(NSError.geocoderFoundNoResult)
                    return
                }

                observer.onNext(placemark)
                observer.onCompleted()
            }
            return Disposables.create {
                base.cancelGeocode()
            }
        }.unwrap()
    }

    /// Reactive wrapper for `CLGeocoder`.`reverseGeocodeLocation(_:preferredLocale:completionHandler:)`
    /// used to search for placemark
    @available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *)
    public func placemark(with location: CLLocation, preferredLocale: Locale) -> Observable<CLPlacemark> {
        return Observable.create { [base] observer in
            base.reverseGeocodeLocation(location, preferredLocale: preferredLocale) { placemarks, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let placemark = placemarks?.first else {
                    observer.onError(NSError.geocoderFoundNoResult)
                    return
                }

                observer.onNext(placemark)
                observer.onCompleted()
            }
            return Disposables.create {
                base.cancelGeocode()
            }
        }.unwrap()
    }

    /// Reactive wrapper for `CLGeocoder`.`geocodeAddressString(_:completionHandler:)`
    /// used to search for placemark
    public func placemarks(with addressString: String) -> Observable<[CLPlacemark]> {
        return Observable.create { [base] observer in
            base.geocodeAddressString(addressString) { placemarks, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                // Forward placemarks Array, because `geocodeAddressString` might not resolve to a single location.
                // See documentation for `CLGeocodeCompletionHandler`
                guard let placemarks = placemarks else {
                    observer.onError(NSError.geocoderFoundNoResult)
                    return
                }

                observer.onNext(placemarks)
                observer.onCompleted()
            }
            return Disposables.create {
                base.cancelGeocode()
            }
        }
    }

    /// Reactive wrapper for `CLGeocoder`.`geocodeAddressString(_:in:completionHandler:)`
    /// used to search for placemark
    public func placemarks(with addressString: String, in region: CLRegion?) -> Observable<[CLPlacemark]> {
        return Observable.create { [base] observer in
            base.geocodeAddressString(addressString, in: region) { placemarks, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                // Forward placemarks Array, because `geocodeAddressString` might not resolve to a single location.
                // See documentation for `CLGeocodeCompletionHandler`
                guard let placemarks = placemarks else {
                    observer.onError(NSError.geocoderFoundNoResult)
                    return
                }

                observer.onNext(placemarks)
                observer.onCompleted()
            }
            return Disposables.create {
                base.cancelGeocode()
            }
        }
    }

    /// Reactive wrapper for `CLGeocoder`.`geocodeAddressString(_:in:preferredLocale:completionHandler:)`
    /// used to search for placemark
    @available(iOS 11.0, OSX 10.13, watchOSApplicationExtension 4.0, tvOS 11.0, *)
    public func placemarks(with addressString: String, in region: CLRegion?, preferredLocale locale: Locale?) -> Observable<[CLPlacemark]> {
        return Observable.create { [base] observer in
            base.geocodeAddressString(addressString, in: region, preferredLocale: locale) { placemarks, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                // Forward placemarks Array, because `geocodeAddressString` might not resolve to a single location.
                // See documentation for `CLGeocodeCompletionHandler`
                guard let placemarks = placemarks else {
                    observer.onError(NSError.geocoderFoundNoResult)
                    return
                }

                observer.onNext(placemarks)
                observer.onCompleted()
            }
            return Disposables.create {
                base.cancelGeocode()
            }
        }
    }
}
