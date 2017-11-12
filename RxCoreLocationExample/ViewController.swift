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
        
        manager.rx.activityType.debug("hehehe").subscribe(onNext: {_ in}).disposed(by: bag)
    }
}

