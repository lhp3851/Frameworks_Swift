//
//  ToolsManager.swift
//  Frameworks_Swift_Example
//
//  Created by sumian on 2019/12/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
//  本类作为一个项目工具的管理类，类似服务端的容器，作为服务的管理类使用

import UIKit



class ServicesManager: NSObject {
    
    static let share = ServicesManager()
    
    var services:[BaseService] = [BaseService]()
    
    private override init() {}
        
    func registe(_ services:[BaseService], completion: (() -> ())?) {
        self.services = services
        services.enumerated().forEach { (idx,service) in
            service.registe(completion: nil)
        }
        if let handler = completion {
            handler()
        }
    }
    
    func boot(completion: (() -> ())?)  {
        if let handler = completion {
            handler()
        }
    }
    
    func stop(completion: (() -> ())?)  {
        if let handler = completion {
            handler()
        }
    }
    
    //load
    
    
    //unload
    
}
