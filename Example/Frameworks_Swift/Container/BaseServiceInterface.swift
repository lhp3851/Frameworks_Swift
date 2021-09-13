//
//  ServiceInterface.swift
//  Frameworks_Swift_Example
//
//  Created by sumian on 2019/12/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


protocol BaseServiceInterface {
    
    /// 服务ID
    var id:String { get }
    
    /// 注册服务
    /// - Parameter completion: 注册完服务后要处理的事件
    func registe(completion:(() -> ())?)
    
    
    /// 批量注册服务
    /// - Parameter services: 服务数组
    /// - Parameter completion: 批量注册完服务后要处理的事件
    func registe(services:[BaseService],completion:(() -> ())?)
    
    
    /// 启动服务
    /// - Parameter completion: 启动完服务后要处理的事
    func boot(completion:(() -> ())?)
    
    
}

extension BaseServiceInterface {
    
    
    /// 想办法获取到协议相应的名字，然后生成UUID
    var id:String {
        
        return UUID.init(uuidString: "")?.uuidString ?? ""
        
    }

    
    func registe(services:[BaseService],completion:(() -> ())?) {}
    
}

