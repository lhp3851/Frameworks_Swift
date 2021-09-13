//
//  BaseViewController.swift
//  WeSeenSwift
//
//  Created by Jerry on 2021/7/18.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, ViewControllerProtocols {
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configDatas()
        setupSubviewes()
        layoutViewes()
    }
    
    func setupSubviewes() {
        view.backgroundColor = UIColor.white
    }
    
    func layoutViewes() {
        
    }
    
    func configDatas() {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isEditing {
            view.endEditing(true)
        }
    }
}

extension BaseViewController {
    func push(to vc: UIViewController, animated: Bool = true, completion:((() -> Void)?) = nil) {
        if let navigatior = self.navigationController {
            if navigatior.viewControllers.count <= 1 {
                vc.hidesBottomBarWhenPushed = true
            }
            navigatior.pushViewController(vc, animated: animated)
        } else {
            self.present(to: vc, animated: animated, completion: completion)
        }
    }
    
    func present(to vc: UIViewController, animated: Bool = true, completion:((() -> Void)?))  {
        self.present(vc, animated: animated, completion: completion)
    }
}
