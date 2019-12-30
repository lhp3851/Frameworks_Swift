//
//  DoraemonService.swift
//  Frameworks_Swift_Example
//
//  Created by sumian on 2019/12/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import DoraemonKit

class DoraemonService: BaseService {
    
    static let share = DoraemonService()
    
    private override init() {
        
    }
    
    override func registe(completion: (() -> ())?) {
        
        DoraemonManager.shareInstance().install()
        
    }

}
