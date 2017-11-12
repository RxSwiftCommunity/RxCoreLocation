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
        manager.rx.activityType.debug("activityType").subscribe(onNext: {_ in}).disposed(by: bag)
        manager.rx.isEnabled.debug("isEnabled").subscribe(onNext: { _ in }).disposed(by: bag)
        manager.rx.didUpdateLocations.debug("didUpdateLocations").subscribe(onNext: { _ in }).disposed(by: bag)
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //manager.rx.location.debug("location").subscribe(onNext: { _ in }).disposed(by: bag)
    }
}

