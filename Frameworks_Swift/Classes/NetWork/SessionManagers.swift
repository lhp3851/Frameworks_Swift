//
//  SessionManagers.swift
//  Frameworks_Swift
//
//  Created by Jerry on 2021/9/13.
//

import Foundation
import Alamofire

public class SessionManagers: NSObject {
    
    enum SessionType {
        case `default`
        case temp
        case background(identifier: String)
    }
    
    static let backgroundIdentifier = "com.we.seen.background.session.identifier"
    
    private lazy var sessionConfig : URLSessionConfiguration = {
        let temp = URLSessionConfiguration.default
        return temp
    }()
    
    private func bacgroundSessionConfig(identifire: String) -> URLSessionConfiguration {
        let temp = URLSessionConfiguration.background(withIdentifier: identifire)
        return temp
    }
    
    private lazy var tempSessionConfig: URLSessionConfiguration = {
        let temp = URLSessionConfiguration.ephemeral
        return temp
    }()
    
    var sessionManager: URLSession?
    
    var cacheEnable: Bool = false
    
    var cookiesEnable: Bool = false
    
    init(_ sessionType: SessionType = SessionType.default,
         cacheEnable: Bool = false,
         cookiesEnable: Bool = false) {
        super.init()
        if case let .background(identifire) = sessionType {
            sessionManager = URLSession(configuration: bacgroundSessionConfig(identifire: identifire))
        } else if case let .temp = sessionType {
            sessionManager = URLSession.init(configuration: tempSessionConfig)
        } else {
            sessionManager = URLSession(configuration: sessionConfig)
        }
    }

}
