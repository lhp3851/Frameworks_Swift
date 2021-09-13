//
//  BaseModel.swift
//  WeSeenSwift
//
//  Created by sumian on 2021/7/23.
//  Copyright © 2021 lhp. All rights reserved.
//
//  ****Valid JSON Object****
//  The object must have the following properties:
//  - Top level object is an NSArray or NSDictionary
//  - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
//  - All dictionary keys are NSStrings
//  - NSNumbers are not NaN or infinity

import UIKit

extension Data {
    
    func toJSONString() -> String? {
        let JSONString = String(data: self, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        return JSONString;
    }
    
    
    func toJSONObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self , options: .mutableContainers) as AnyObject;
        } catch {
            print(error);
        }
        return nil;
    }
    
}

extension String {
    
    func toData() -> Data? {
        let jsonData = self.data(using: String.Encoding.utf8, allowLossyConversion: false);
        return jsonData;
    }
    
    func toJson() -> Any? {
        do {
            let encodeData = try? JSONEncoder().encode(self)
            if let data = encodeData {
                let jsonString = String(data: data, encoding: .utf8)
                return jsonString
            }
            return nil
        }
    }
    
}

extension Dictionary {
    func toJSONString(object: Any) -> String? {
        do {
            if JSONSerialization.isValidJSONObject(object) {
                let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]);
                let JSONString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
                return JSONString;
            } else {
                return nil
            }
        } catch {
            print(error);
        }
        return nil;
    }
}

extension Array {
    
    func toJSONString(object: Any) -> String? {
        do {
            if JSONSerialization.isValidJSONObject(object) {
                let data = try JSONSerialization.data(withJSONObject: object, options: []);
                let JSONString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
                return JSONString;
            } else {
                return nil
            }
        } catch {
            print(error);
        }
        return nil;
    }
}



class BaseModel: NSObject, Codable {
    
    var id: Int = 0
    
    enum BaseModelCodingKeys:String, CodingKey {
        case id
    }
    
    required init(from: Decoder) {
        do {
            let container = try? from.container(keyedBy: BaseModelCodingKeys.self)
            let id = try container?.decode(Int.self, forKey: .id)
            self.id = id ?? 0
        } catch  {
            print(error)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BaseModelCodingKeys.self)
        try container.encode("id", forKey: .id)
    }
    
    func toData(json: Any) -> Data? {
        do {
            if JSONSerialization.isValidJSONObject(json) {
                return try JSONSerialization.data(withJSONObject: json, options: []);
            } else {
                return nil
            }
        } catch {
            print(error);
        }
        return nil;
    }
    
    
}
