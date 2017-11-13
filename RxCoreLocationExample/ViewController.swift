//
//  ViewController.swift
//  RxCoreLocationExample
//
//  Created by Bob Obi on 10.11.17.
//  Copyright © 2017 Bob Godwin. All rights reserved.
//

import UIKit
import CoreLocation
import RxCoreLocation
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    let bag = DisposeBag()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setup CLLocationManager
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        /// Start Subscribing
        /// Works on simulator and device
        /// Subscribe to didUpdateLocations
        manager.rx
            .didUpdateLocations
            .debug("didUpdateLocations")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to didChangeAuthorization
        manager.rx
            .didChangeAuthorization
            .debug("didChangeAuthorization")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to location
        manager.rx
            .location
            .debug("location")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to activityType
        manager.rx
            .activityType
            .debug("activityType")
            .subscribe(onNext: {_ in})
            .disposed(by: bag)
        
        /// Subscribe to isEnabled
        manager.rx
            .isEnabled
            .debug("isEnabled")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to didError
        manager.rx
            .didError
            .debug("didError")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        ///Note works on Device
        
        /// Subscribe to didDetermineState
        manager.rx
            .didDetermineState
            .debug("didDetermineState")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to didReceiveRegion
        manager.rx
            .didReceiveRegion
            .debug("didReceiveRegion")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to didResume
        manager.rx
            .didResume
            .debug("didResume")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
    }
}

