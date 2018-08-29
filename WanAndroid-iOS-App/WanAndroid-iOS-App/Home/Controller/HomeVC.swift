
//
//  HomeVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit
import Alamofire



// 这里用UITableViewController  为了使用自带的下拉刷新
class HomeVC: UITableViewController{
    
    // 首页文章列表数据
    var mArticleData : [AnyObject]?
    //    var tableView : UITableView?
    
    // 是否存在下一页
    var mHasNextPage = true
    
    // footView 加载更多
    var footView : UILabel?
    
    // 当前页面
    var mPage = 0
    
    // 判断是否在请求中。
    var mIsRequesting = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // 设置 title
        self.navigationItem.title = "主页";
        
        //        // 生成 TableView
        //        self.tableView = UITableView.init(frame: self.view.bounds)
        //
        //        // 设置代理和数据源
        //        tableView?.delegate = self
        //        tableView?.dataSource = self
        
        
        
        // 给TableView设置 cell
        tableView?.register(UINib.init(nibName: "HomeArticleCell", bundle:nil), forCellReuseIdentifier:"HomeArticleCell")
        //        tableView?.register(HomeArticleCell.self, forCellReuseIdentifier: "HomeArticleCell")
        // 添加到当前view
        //        self.view.addSubview(tableView!)
        
        tableView?.estimatedRowHeight = 115.0
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        
        // 下拉刷新
        refreshControl = UIRefreshControl.init()
        refreshControl!.attributedTitle = NSAttributedString.init(string: "下拉刷新...")
        refreshControl!.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        
        tableView!.refreshControl = refreshControl
        
        // 去掉多的分割线  上拉加载更多
        footView = UILabel.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        footView!.font.withSize(11.0)
        footView!.textAlignment = .center
        footView!.textColor = UIColor.gray
        footView!.layoutMargins = UIEdgeInsets.init(top: 5.0, left: 0.0, bottom: 12.0, right: 0.0)
        footView!.text = "上拉加载更多"
        tableView?.tableFooterView = footView
        
        // 开始请求数据
        getHomeArticleData();
        
    }
    
    @objc func refresh(){
        getHomeArticleData()
    }
    
    // 获取列表总数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mArticleData?.count ?? 0
    }
    
    
    
    // 获取每一个cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeArticleCell") as? HomeArticleCell
        
        cell?.itemData = mArticleData?[indexPath.row] as? Dictionary<String,AnyObject>
        return cell!;
    }
    
    // 处理点击事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
        // 去掉这个选中的灰色背影
        tableView.deselectRow(at: indexPath, animated: true)
        //        print(mArticleData?[indexPath.row])
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // tableview当前可见顶部在tableview中的y轴位置
        let currentOffsetY = scrollView.contentOffset.y
        // 屏幕内容高度
        let contentScreenHeight = scrollView.frame.size.height
        // 如果上面两个相加大于 tableview 的所有内容的高度就触发加载更多了
        if(currentOffsetY + contentScreenHeight > scrollView.contentSize.height + 30.0 && !mIsRequesting && mHasNextPage){
            // 触发上拉加载更多
            getHomeArticleData(true)
        }
    }
    
    
    // 获取数据
    func getHomeArticleData(_ loadMore : Bool = false){
        
        mIsRequesting = true
        
        if(!loadMore){
            mPage = 0
        }else{
            mPage += 1
            // 改变一下加载更多的提示
            footView?.text = "正在加载中...."
        }
        print("加载数据\(loadMore) \(mPage)")
        HttpUtils.requestData(urlString: "http://www.wanandroid.com/article/list/\(mPage)/json", type: MethodType.get, callBack: {(value) in
            
            self.mIsRequesting = false
            
            // 请求失败的时候就这样处理吧。
            if(value == nil){
                if(loadMore){
                    self.mPage -= 1
                    self.footView?.text = "上拉加载更多"
                }else {
                    self.refreshControl?.endRefreshing()
                }
                self.mIsRequesting = false
                return
            }
            
            
            let dictionary = value as! [String : AnyObject]
            // errorCode errorMsg data
            if((dictionary["errorCode"] as! Int) == 0){
                // 请求成功
                // print(dictionary["data"])
                // 把值设置给view绑定。
                let data = dictionary["data"] as? [String : AnyObject]
                let newData = data?["datas"] as? [AnyObject]
                
                // 设置新数据
                if(loadMore){
                    newData?.forEach(({ (obj) in
                        self.mArticleData?.append(obj)
                    }))
                    self.footView?.text = "上拉加载更多"
                }else{
                    self.mArticleData = newData
                    self.refreshControl?.endRefreshing()
                }
                
                // 再判断一下数据还有没有下载更多
                self.mHasNextPage =  self.mArticleData!.count < data!["total"] as! Int
                
                
                // 刷新 TableView
                self.tableView?.reloadData()
                
            }
        })
    }
    
}

