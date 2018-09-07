//
//  KnowledgeChildTabVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/9/6.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit
import SnapKit
import Tabman
import Pageboy



class KnowledgeChildTabVC: TabmanViewController, PageboyViewControllerDataSource {
    

    
    var tabTitles : [String]
    var tabIds : [Int]
    
    var viewControllers: [UIViewController] = []
    
    
    init(_ tabTitles: [String], _ tabIds: [Int]) {
        self.tabIds = tabIds
        self.tabTitles = tabTitles
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = title;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // tab数据
        var tabItems: [Item] = []
        
        viewControllers.removeAll()
        
        for tabTitle in tabTitles {
            tabItems.append(Item.init(title: tabTitle))
        }
        for tabId in tabIds {
            // VC 数据
            viewControllers.append(KnowledgeChildPageVC(tabId))
        }
        self.bar.items = tabItems
        self.bar.style = .scrollingButtonBar
        
        
        // 我去，这里要在 viewControllers有了数据之后再设置，不然不生效的。
        self.dataSource = self
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}

