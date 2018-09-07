//
//  HomeVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class KnowledgeVC: UITableViewController {
    
    lazy var tabCell  = UITableViewCell.init(style: .subtitle, reuseIdentifier: "TableViewCell")
    
    var mData : [Any]?

    override func viewDidAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "知识体系";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();

        
        self.tableView.register(UINib.init(nibName: "KnowledgeCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        
        tableView?.estimatedRowHeight = 110.0
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.attributedTitle = NSAttributedString.init(string: "下拉刷新...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.tableView.refreshControl = refreshControl
        
//        self.tableView.tableFooterView = UIView()
        
        
        getData()
    }
    
    // 刷新
    @objc func refresh(){
        
        getData()
    }
    
    
    // 点击某一个
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemData = mData?[indexPath.row] as? [String : Any]
        let title = itemData?["name"] as? String
        // 跳转页面

        var tabTitles : [String] = []
        var tabIds : [Int] = []
        
        if let childrens = itemData?["children"] as? [Any] {
            for child in childrens {
                let childItem = child as! [String : Any]
                tabTitles.append(childItem["name"] as! String)
                tabIds.append(childItem["id"] as! Int)
            }
        }
        let targetVC = KnowledgeChildTabVC(tabTitles, tabIds)
        targetVC.title  =  title


        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    // 一组的个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mData?.count ?? 0
    }
    
    
    // 返回 cell 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? KnowledgeCell
   
        cell?.itemData = mData?[indexPath.row] as? [String : Any]
        
        return cell!
    }
    
    
    
    
    
    // 获取数据 
    func getData(){
        HttpUtils.requestData(urlString: "http://www.wanandroid.com/tree/json", type: .get
            , callBack: {(value) in
            
                self.refreshControl?.endRefreshing()
                
                if(value == nil){
                    return
                }
                
                let data = value as! [String : Any]
                
                if((data["errorCode"] as! Int) == 0){
                    self.mData = data["data"] as? [Any]
                    self.tableView.reloadData()
                }else{
                    self.view.makeToast(data["errorMsg"] as? String)
                }
                
    
                
        })
    }
    
    
}
