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
    
}
