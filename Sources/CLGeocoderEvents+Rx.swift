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
                base.cancelGeocode()
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
                base.cancelGeocode()
                observer.onCompleted()
            }
        }.unwrap()
    }

    /// Reactive wrapper for `CLGeocoder`.`geocodeAddressString(_:completionHandler:)`
    /// used to search for placemark
    public func placemarks(with addressString: String) -> Observable<[CLPlacemark]> {
        return Observable.create { [base] observer in
            base.geocodeAddressString(addressString) { placemarks, _ in
                guard let placemarks = placemarks else {
                    observer.onError(NSError(domain: CLError.errorDomain, code: CLError.geocodeFoundNoResult.rawValue, userInfo: nil))
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
            base.geocodeAddressString(addressString, in: region) { placemarks, _ in
                guard let placemarks = placemarks else {
                    observer.onError(NSError(domain: CLError.errorDomain, code: CLError.geocodeFoundNoResult.rawValue, userInfo: nil))
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
            base.geocodeAddressString(addressString, in: region, preferredLocale: locale) { placemarks, _ in
                guard let placemarks = placemarks else {
                    observer.onError(NSError(domain: CLError.errorDomain, code: CLError.geocodeFoundNoResult.rawValue, userInfo: nil))
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
