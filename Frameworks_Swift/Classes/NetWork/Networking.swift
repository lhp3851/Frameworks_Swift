//
//  KKNetWorkManager.swift
//  Frameworks_Swift
//
//  Created by sumian on 2019/6/6.
//

import UIKit
import Moya
import Alamofire
import SwiftyJSON

open class Networking: NSObject {
    
    let loggerPlugin = LoggerPlugin.logger(type: .default)
    
    lazy var trustManager: ServerTrustManager = {
        let host = URL(string: "")?.host ?? "sdapi.sumian.com"
        let evaluators: [String: ServerTrustEvaluating] = [
            host: DefaultTrustEvaluator(),
        ]
        let temp = ServerTrustManager(allHostsMustBeEvaluated: false,
                                      evaluators: evaluators)
        return temp
    }()
    
    lazy var authTokenPlugin: AccessTokenPlugin = {
        let temp = AccessTokenPlugin { target in
            return ""
        }
        return temp
    }()
    
    lazy var activityPlugin: NetworkActivityPlugin = {
        let temp = NetworkActivityPlugin {[weak self] activityType, target in
            switch activityType {
            case .began:
                self?.callbackQueue.async {
                    print("🤜\(target.baseURL) + \(target.path)")
                }
            case .ended:
                self?.callbackQueue.async {
                    print("🤛\(target.baseURL) + \(target.path)")
                }
            }
        }
        return temp
    }()
    
    lazy var interceptor: Interceptor = {
        let temp = Interceptor()
        return temp
    }()
    
    lazy var redirectHandler: RedirectHandler = {
        let temp = Redirector(behavior: .follow)
        return temp
    }()
    
    lazy var cacheResponseHandler: ResponseCacher = {
        let temp = ResponseCacher(behavior: .cache)
        return temp
    }()
    
    lazy var session: Session = {
        let configurations = URLSessionConfiguration.default
            /// 后面做到设置里面去，用户可以根据流量使用情况选择是否使用移动网络
        configurations.allowsCellularAccess = true
        configurations.timeoutIntervalForRequest = 30
        let temp = Session.init(configuration: configurations,
                                startRequestsImmediately: true,
                                interceptor: interceptor,
                                serverTrustManager: trustManager,
                                redirectHandler: redirectHandler,
                                cachedResponseHandler: cacheResponseHandler,
                                eventMonitors: [])
        return temp
    }()
    
    lazy var transferSession: Session = {
        let configurations = URLSessionConfiguration.default
            /// 后面做到设置里面去，用户可以根据流量使用情况选择是否使用移动网络
        configurations.allowsCellularAccess = true
        configurations.timeoutIntervalForRequest = 60
        let temp = Session.init(configuration: configurations,
                                startRequestsImmediately: true,
                                interceptor: interceptor,
                                serverTrustManager: trustManager,
                                redirectHandler: redirectHandler,
                                eventMonitors: [])
        return temp
    }()
    
    lazy var callbackQueue: DispatchQueue = {
        let queue = DispatchQueue.global(qos: .default)
        return queue
    }()
    
    lazy var provider: MoyaProvider<MultiTarget> = {
        let temp = MoyaProvider<MultiTarget>(session: session,
                                              plugins: [authTokenPlugin, loggerPlugin])
        return temp
    }()
    
    lazy var downloadProvider: MoyaProvider<MultiTarget> = {
        let temp = MoyaProvider<MultiTarget>(session: transferSession,
                                                plugins: [authTokenPlugin, loggerPlugin])
        return temp
    }()
    
    lazy var uploadProvider: MoyaProvider<MultiTarget> = {
        let temp = MoyaProvider<MultiTarget>(session: transferSession,
                                              plugins: [authTokenPlugin, loggerPlugin])
        return temp
    }()
    
    public func request<Model>(target: MultiTarget, model: Model.Type = Model.self, completion: @escaping Completion) -> Cancellable where Model: Jsonable {
        provider.request(target, callbackQueue: callbackQueue) { progressResponse in
            print(progressResponse.progress)
        } completion: { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                if let successResponse = try? response.filterSuccessfulStatusCodes() {
                    let model = Model(JSON(response.data))
                    completion(.success(model as! Response))
                } else if let redirectResponse = try? response.filter(statusCodes: 300...399) {
                    let error = ErrorObject(fromJson: JSON(response.data))
                    completion(.failure(.underlying(error.error.toNSError, response)))
                } else if let localResponse = try? response.filter(statusCodes: 400...499) {
                    let message = JSON(response.data)["message"].string
                    let error = ErrorObject(fromJson: JSON(response.data))
                    completion(.failure(.underlying(NSError.error(code: response.statusCode, message: message), response)))
                } else if let remoteResponseError = try? response.filter(statusCodes: 500...599) {
                    let error = ErrorObject(fromJson: JSON(response.data))
                    completion(.failure(.underlying(error.error.toNSError, response)))
                } else {
                    completion(.failure(.statusCode(response)))
                }
            case let .failure(moyaError):
                completion(.failure(moyaError))
            }
        }
    }
    
    @discardableResult
    public func download(_ target: MultiTarget,
                  progressHandler: @escaping Moya.ProgressBlock,
                  callbackQueue: DispatchQueue? = DispatchQueue.global(qos: .default),
                  completionHandler: ((_ result: Result<Response, MoyaError>) -> Void)?) -> Cancellable {
        return downloadProvider.request(target, callbackQueue: callbackQueue, progress: progressHandler) { result in
            switch result {
            case let .success(response):
                print("download succed: \(String(describing: response.response?.statusCode))")
            case let .failure(error):
                print("downlaod failed because: \(error.localizedDescription)")
            }
        }
    }
    
    @discardableResult
    func upload(_ target: MultiTarget,
                progressHandler: @escaping Moya.ProgressBlock,
                callbackQueue: DispatchQueue? = DispatchQueue.global(qos: .default),
                completionHandler: ((_ result: Result<Response, MoyaError>) -> Void)?) -> Cancellable {
        return uploadProvider.request(target, callbackQueue: callbackQueue, progress: progressHandler) { result in
            switch result {
            case let .success(response):
                print("download succed: \(String(describing: response.response?.statusCode))")
            case let .failure(error):
                print("downlaod failed because: \(error.localizedDescription)")
            }
        }
    }
    
}



