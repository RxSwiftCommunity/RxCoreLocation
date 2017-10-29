//
//  RxCLLocationManagerDelegateProxy.swift
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

public typealias RxCLLocationManagerDelegate = DelegateProxy<CLLocationManager, CLLocationManagerDelegate>

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

open class RxCLLocationManagerDelegateProxy: RxCLLocationManagerDelegate, DelegateProxyType, CLLocationManagerDelegate {
    
    /// Type of parent object
    public weak private(set) var manager: CLLocationManager?
    
    /// Init with ParentObject
    public init(parentObject: ParentObject) {
        manager = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxCLLocationManagerDelegateProxy in
            RxCLLocationManagerDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `CLLocationManagerDelegate` on `CLLocationManager`
    open class func currentDelegate(for object: ParentObject) -> CLLocationManagerDelegate? {
        return object.delegate
    }
    
    /// Set the CLLocationManagerDelegate for `CLLocationManager`
    open class func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
}
