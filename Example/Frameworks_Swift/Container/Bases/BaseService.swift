//
//  BaseService.swift
//  Frameworks_Swift_Example
//
//  Created by sumian on 2019/12/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class BaseService: NSObject,BaseServiceInterface {
    
    func registe(completion: (() -> ())?) {
        if let handler = completion {
            handler()
        }
    }
    
    func registe(services: [BaseService], completion: (() -> ())?) {
        services.enumerated().forEach { (idx,service) in
            service.registe(completion: nil)
        }
        if let handler = completion {
            handler()
        }
    }
    
    func boot(completion: (() -> ())?) {
        if let handler = completion {
            handler()
        }
    }
    
}
