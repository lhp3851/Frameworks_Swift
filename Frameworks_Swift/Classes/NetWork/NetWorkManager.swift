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

class NetWorkManager: NSObject {
    
    lazy var provider: MoyaProvider<MultiTarget> = {
        let temp = MoyaProvider<MultiTarget>()
        return temp
    }()
    
    var callBackQueue: DispatchQueue {
        let queue = DispatchQueue.global(qos: .default)
        return queue
    }
    
    func request<Model>(target: MultiTarget, model: Model.Type = Model.self, completion: @escaping Completion) -> Cancellable where Model: Jsonable {
        provider.request(target, callbackQueue: callBackQueue) { progressResponse in
            print(progressResponse.progress)
        } completion: { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                if let successResponse = try? response.filterSuccessfulStatusCodes() {
                    let model = Model(fromJson: JSON(response.data))
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
    
}



