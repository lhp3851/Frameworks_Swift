//
//  NSErrorExtension.swift
//  Frameworks_Swift
//
//  Created by Jerry on 2021/9/14.
//

import Foundation

extension NSError {
    static let ryDomain = "domain.Error.Ry"
    
    static func error(domain: String = ryDomain,code:Int,message: String?) -> NSError{
        var userInfo: [String : Any]? = nil
        if let message = message{
            userInfo = [NSLocalizedDescriptionKey: message]
        }
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
    
    static var unknowError: NSError{
        return NSError.error(code: 0,message: "未知错误")
    }
    
    static var badNetWorkError: NSError{
        return NSError.error(code: NSURLErrorNotConnectedToInternet, message: "网络异常，请检查您的网络")
    }
    
    static var unknowErrorForLogin: NSError{
        return NSError.error(code: 1, message: "登录异常,请重新登录")
    }
    
}
