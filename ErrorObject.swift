//
//  ErrorObject.swift
//  Frameworks_Swift
//
//  Created by Jerry on 2021/9/13.
//

import UIKit
import SwiftyJSON

class ErrorObject: NSObject, NSCoding {

    var error : Error = Error(fromJson: .null)
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let errorJson = json["error"]
        if !errorJson.isEmpty{
            error = Error(fromJson: errorJson)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if error != nil{
            dictionary["error"] = error.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        error = aDecoder.decodeObject(forKey: "error") as! Error
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if error != nil{
            aCoder.encode(error, forKey: "error")
        }
        
    }
    
    @objc(_TtCC16Frameworks_Swift11ErrorObject5Error)class Error: NSObject, NSCoding {
        var code : Int!
        var info : String!
        var internalMessage : String!
        var userMessage : String!
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json.isEmpty{
                return
            }
            code = json["code"].intValue
            info = json["info"].stringValue
            internalMessage = json["internalMessage"].stringValue
            userMessage = json["userMessage"].stringValue
        }
        
        /**
         * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
         */
        func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            if code != nil{
                dictionary["code"] = code
            }
            if info != nil{
                dictionary["info"] = info
            }
            if internalMessage != nil{
                dictionary["internalMessage"] = internalMessage
            }
            if userMessage != nil{
                dictionary["userMessage"] = userMessage
            }
            return dictionary
        }
        
        /**
         * NSCoding required initializer.
         * Fills the data from the passed decoder
         */
        @objc required init(coder aDecoder: NSCoder)
        {
            code = aDecoder.decodeObject(forKey: "code") as? Int
            info = aDecoder.decodeObject(forKey: "info") as? String
            internalMessage = aDecoder.decodeObject(forKey: "internalMessage") as? String
            userMessage = aDecoder.decodeObject(forKey: "userMessage") as? String
        }
        
        /**
         * NSCoding required method.
         * Encodes mode properties into the decoder
         */
        func encode(with aCoder: NSCoder)
        {
            if code != nil{
                aCoder.encode(code, forKey: "code")
            }
            if info != nil{
                aCoder.encode(info, forKey: "info")
            }
            if internalMessage != nil{
                aCoder.encode(internalMessage, forKey: "internalMessage")
            }
            if userMessage != nil{
                aCoder.encode(userMessage, forKey: "userMessage")
            }
            
        }
        
        var toNSError: NSError{
            return NSError.error(code: code, message: userMessage)
        }
    }
    
}

protocol Jsonable {
        
    init(fromJson: JSON)
    
//    func toJson() -> Model?
    
}
