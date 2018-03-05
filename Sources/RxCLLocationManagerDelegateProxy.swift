//
//  RxCLLocationManagerDelegateProxy.swift
//  RxCoreLocation
//
//  Created by Bob Godwin Obi on 10/29/17.
//  Copyright © 2017 RxCoreLocation. All rights reserved.
//

import class CoreLocation.CLLocationManager
import protocol CoreLocation.CLLocationManagerDelegate
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

public class RxCLLocationManagerDelegateProxy: DelegateProxy, CLLocationManagerDelegate, DelegateProxyType {
    /// Type of parent object
    public weak private(set) var manager: CLLocationManager?

    // MARK: Initializers

    /// Init with ParentObject
    public required init(parentObject: AnyObject) {
        manager = castOrFatalError(parentObject)

        super.init(parentObject: parentObject)
    }

    // MARK: DelegateProxyType conforms

    /// Gets the current `CLLocationManagerDelegate` on `CLLocationManager`
    public static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let manager: CLLocationManager = castOrFatalError(object)

        return manager.delegate
    }

    /// Set the CLLocationManagerDelegate for `CLLocationManager`
    public static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let manager: CLLocationManager = castOrFatalError(object)
        manager.delegate = castOptionalOrFatalError(delegate)
    }
}
