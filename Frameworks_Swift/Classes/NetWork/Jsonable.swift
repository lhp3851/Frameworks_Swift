//
//  Jsonable.swift
//  Frameworks_Swift
//
//  Created by Jerry on 2022/8/14.
//

import Foundation
import SwiftyJSON

public protocol Jsonable {
    
    init(_ jsonData: Data)
    
    init(_ jsonData: JSON)
    
}

extension Jsonable {
    
    init(_ jsonData: Data) {
        do {
            let json = try JSON(data: jsonData)
            self.init(json)
        } catch let error {
            print(error.localizedDescription)
        }
        self.init(.null)
    }
    
}
