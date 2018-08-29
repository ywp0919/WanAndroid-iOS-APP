//
//  HomeArticleCell.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/27.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

// cell view   md xid 真的难玩，好恶心，手打代码算了。
class HomeArticleCell: UITableViewCell {
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelTitle: UILabel!

    
    // 没做模型转换了，先这样取出来实现一下。
    var itemData:Dictionary<String,AnyObject>? {
        didSet {
            
            labelAuthor.text = itemData?["author"] as? String
            labelTitle.text = (itemData?["title"] as! String) 
            labelType.text = itemData?["superChapterName"] as? String
  
        }
    }
    

    
}

