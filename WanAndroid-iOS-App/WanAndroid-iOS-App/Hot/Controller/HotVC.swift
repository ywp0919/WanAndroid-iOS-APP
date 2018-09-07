//
//  HotVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class HotVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    static let HEAD_ID = "head"
    static let CELL_ID = "cell"
    
    
    var colors = [
        UIColor.withHex(hexInt: 0x41BAE9),
        UIColor.withHex(hexInt: 0xF38083),
        UIColor.withHex(hexInt: 0x828528),
        UIColor.withHex(hexInt: 0x148583),
        UIColor.withHex(hexInt: 0xF28317)
    ];
    
    var sectionCount = 1
    var cellData:[Any]?
    
    var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.parent?.navigationItem.title = "热门";
        
        let layout = UICollectionViewFlowLayout()
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 50.0)
        //        layout.footerReferenceSize = CGSize.init(width: 100.0, height: 10.0)
        layout.sectionHeadersPinToVisibleBounds = false
        //        layout.sectionFootersPinToVisibleBounds = false
        
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        //        layout.sectionInset = UIEdgeInsets.init(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        layout.estimatedItemSize = CGSize.init(width: 20, height: 20)
        //        layout.itemSize = CGSize.init(width: 30, height: 30)
        
        
        collectionView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        
        //        collectionView!.bounces = true
        //        collectionView!.alwaysBounceVertical = true
        
        
        collectionView!.backgroundColor = UIColor.white
        
        //        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HotVC.FOOT_ID)
        
        
        
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        self.view.addSubview(collectionView!)
        
        collectionView!.register(HotTextLabelCell.classForCoder(), forCellWithReuseIdentifier: HotVC.CELL_ID)
        collectionView!.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HotVC.HEAD_ID)
        
        collectionView?.snp.makeConstraints({ (make) in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(8)
            make.right.equalTo(view).offset(-8)
            make.bottom.equalTo(view).offset(8)
        })
        
        getHotWebsite()
        
    }
    
  
    
    
    
}
//// datasource
extension HotVC{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
//        if(kind == UICollectionElementKindSectionHeader){
            var head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HotVC.HEAD_ID, for: indexPath)
        
            let lable = UILabel.init(frame: head.frame)
            lable.text = "热门网站"
            lable.textAlignment = .center
            head.addSubview(lable)
            
//            head.backgroundColor = UIColor.withHex(hexString: "BABFC8")
        

            return head;
//        }
//        else {
//            var foot = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HotVC.FOOT_ID, for: indexPath)
//
//            foot.backgroundColor = UIColor.green
//
//            return foot;
//        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotVC.CELL_ID, for: indexPath) as! HotTextLabelCell
        
        let itemData = cellData?[indexPath.row] as? [String : Any]
        let name = itemData?["name"] as? String
        cell.textLabel.text = name
        
        cell.backgroundColor = colors[indexPath.row % 5]
//        cell.backgroundColor = UIColor.init(red: CGFloat(arc4random() % 256)/255.0,
//                                            green: CGFloat(arc4random() % 256)/255.0,
//                                            blue: CGFloat(arc4random() % 256)/255.0,
//                                            alpha: 0.8)
        
        return cell;
    }
    
}


//// UICollectionViewDelegate
extension HotVC{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemData = cellData?[indexPath.row] as? [String : Any]
        let name = itemData?["name"] as? String
        let link = itemData?["link"] as? String
        
        let targetVC = MyWebViewVC()
        targetVC.title = name
        targetVC.url = link
        targetVC.isCollect = (itemData?["collect"] as? Bool ) ?? false
        self.navigationController?.pushViewController(targetVC, animated: true)
        
    }
    
    
}


//// 网络请求

extension HotVC{
    
    func getHotWebsite(){
        HttpUtils.requestData(urlString: "http://www.wanandroid.com/friend/json", type: .get) { (value) in
            
            if value == nil {
                return
            }
            
            let valueData = value as! [String : Any]
            self.cellData = valueData["data"] as? [Any]
            
            self.collectionView?.reloadData()
            
        }
    }
    
}

