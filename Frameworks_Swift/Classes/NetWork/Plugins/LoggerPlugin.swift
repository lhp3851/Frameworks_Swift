//
//  LoggerPlugin.swift
//  Alamofire
//
//  Created by Jerry on 2022/8/14.
//

import Moya

public class LoggerPlugin: NSObject {
    
    enum NetworkLoggerType {
        case `default`
        case verbose
    }
    
    static func console(target: TargetType, items: [String])  {
        for item in items {
            DispatchQueue.global(qos: .background).async {
                print(item, separator: ",", terminator: "\n")
            }
        }
    }
    
    static func logger(type: NetworkLoggerType = .default) -> NetworkLoggerPlugin {
        let loggerFormatter = NetworkLoggerPlugin.Configuration.Formatter()
        var logOptions = NetworkLoggerPlugin.Configuration.LogOptions.default
        switch type {
        case .verbose:
            logOptions = NetworkLoggerPlugin.Configuration.LogOptions.verbose
            let configs = NetworkLoggerPlugin.Configuration(formatter: loggerFormatter,
                                                            output: LoggerPlugin.console,
                                                            logOptions: logOptions)
            return NetworkLoggerPlugin(configuration: configs)
        default:
            let configs = NetworkLoggerPlugin.Configuration(formatter: loggerFormatter,
                                                            output: LoggerPlugin.console,
                                                            logOptions: logOptions)
            return NetworkLoggerPlugin(configuration: configs)
        }
    }

}
