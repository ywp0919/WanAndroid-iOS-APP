//
//  MyCollectArticleVCTableViewController.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/31.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

// 这个页面完全复用首页的文章页面，只有接口的修改，和取消收藏的判断逻辑的修改。
class MyCollectArticleVC: UITableViewController {

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
        self.navigationItem.title = "我喜欢的文章";
        
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
        
        
        // 通知接收器
        NotificationCenter.default.addObserver(self, selector: #selector(getHomeArticleData), name: NSNotification.Name.init(Noti_Login_In), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getHomeArticleData), name: NSNotification.Name.init(Noti_Login_Out), object: nil)
        
        
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
        
        // 星星 status
        cell?.imageStar.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(changeCollectStatu(_:)))
        cell?.imageStar.tag = indexPath.row
        cell?.imageStar.addGestureRecognizer(gesture)
        
        
        
        cell?.itemData = mArticleData?[indexPath.row] as? Dictionary<String,AnyObject>
        return cell!;
    }
    
    // 改变收藏状态  注意这里的sender是拿到的UITapGestureRecognizer  再通过它拿view再拿tag
    // 这里
    @objc func changeCollectStatu(_ sender : UITapGestureRecognizer){
        let index = sender.view!.tag as Int
        
        let itemData = mArticleData?[index] as? [String : AnyObject]
        let star = itemData?["collect"] as? Bool
    
        let id = itemData?["id"] as? Int ?? 0
        
        // 我的收藏列表的数据里面根本就没有这个coolect字段，直接触发取消就行了。
        removeArticleCollect(id, index: index)
        
        
//
//        print(id)
//        if(star){
////            http://www.wanandroid.com/lg/uncollect/2805/json
////            方法：POST
////            参数：
////            id:拼接在链接上
////            originId:列表页下发，无则为-1
//            removeArticleCollect(id, index: index)
//        }
//        else{
//            // 去添加收藏
//            // http://www.wanandroid.com/lg/collect/1165/json
//            //            方法：POST
//            //            参数： 文章id，拼接在链接中。
//            addArticleCollect(id, index: index)
//        }
        
    }
    
    // 处理点击事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
        // 去掉这个选中的灰色背影
        tableView.deselectRow(at: indexPath, animated: true)
        //        print(mArticleData?[indexPath.row])
        let targetVC = MyWebViewVC()
        var item = mArticleData?[indexPath.row] as? Dictionary<String,AnyObject>
        targetVC.title = item?["title"] as? String
        targetVC.url = item?["link"] as? String
        
        //        let targetNVC = UINavigationController.init(rootViewController: targetVC)
        
        
        //        self.present(targetNVC, animated: true, completion: nil)
        
        
        navigationController?.pushViewController(targetVC, animated: true)
        
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
    
    // 移除通知监听
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
}

// 网络请求
extension MyCollectArticleVC {
    // 获取数据
    @objc func getHomeArticleData(_ loadMore : Bool = false){
        
        mIsRequesting = true
        
        if(!loadMore){
            mPage = 0
        }else{
            mPage += 1
            // 改变一下加载更多的提示
            footView?.text = "正在加载中...."
        }
        print("加载数据\(loadMore) \(mPage)")
        HttpUtils.requestData(urlString: "http://www.wanandroid.com/lg/collect/list/\(mPage)/json", type: MethodType.get, callBack: {(value) in
            
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
    
    // 取消收藏 http://www.wanandroid.com/lg/uncollect/2805/json
//    方法：POST
//    参数：
//    id:拼接在链接上
//    originId:列表页下发，无则为-1
    func removeArticleCollect(_ id : Int, index : Int){
        
        let url = "http://www.wanandroid.com/lg/uncollect/\(id)/json"
//        originId
        let originId = (mArticleData?[index] as? [String : Any])?["originId"]
        let params = ["originId" : originId]
        
        HttpUtils.requestData(urlString: url, type: .post, params:params) { (value) in
            if let value = value {
                let value = value as? [String : Any]
                if((value!["errorCode"] as! Int) == 0){
                    // 成功
//                    var itemData = self.mArticleData?[index] as? [String : Any]
//                    itemData!["collect"] = false
//                    self.mArticleData?[index] = itemData as AnyObject
                    
                    // 这里的成功是直接把这条数据给删除掉了，不需要改变状态了。
                    self.mArticleData?.remove(at: index)
                    self.tableView.reloadData()
                }else {
                    // 失败
                    self.view.makeToast(value?["errorMsg"] as? String)
                }
            }else{
                self.view.makeToast("请求失败")
            }
        }
    }
    
    // 添加收藏            // http://www.wanandroid.com/lg/collect/1165/json
    func addArticleCollect(_ id : Int, index : Int){
        let url = "http://www.wanandroid.com/lg/collect/\(id)/json"
        
        HttpUtils.requestData(urlString: url, type: .post) { (value) in
            if let value = value {
                let value = value as? [String : Any]
                if((value!["errorCode"] as! Int) == 0){
                    // 成功
                    var itemData = self.mArticleData?[index] as? [String : Any]
                    itemData!["collect"] = true
                    self.mArticleData?[index] = itemData as AnyObject
                    self.tableView.reloadData()
                }else {
                    // 失败
                    self.view.makeToast(value?["errorMsg"] as? String)
                }
            }else{
                self.view.makeToast("请求失败")
            }
        }
    }

}
