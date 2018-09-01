//
//  HotVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class HotVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "热门";
    }
}

