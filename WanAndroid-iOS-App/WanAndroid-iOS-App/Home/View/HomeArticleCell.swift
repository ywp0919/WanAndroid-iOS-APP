//
//  HomeArticleCell.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/27.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

// cell view
class HomeArticleCell: UITableViewCell {
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageStar: UIImageView!
    
    // 没做模型转换了，先这样取出来实现一下。
    var itemData:Dictionary<String,AnyObject>? {
        didSet {
            
            labelAuthor.text = itemData?["author"] as? String
            // 这里要处理下 搜索返回的高亮
            var title = (itemData?["title"] as! String)
            if(title.contains("<em")){
                title = title.replacingOccurrences(of: "<em class='highlight'>", with: "")
                title = title.replacingOccurrences(of: "</em>", with: "")
            }
            labelTitle.text = title
            
            labelType.text = itemData?["superChapterName"] as? String
            
            let star = itemData?["collect"] as? Bool
            
            // 我的收藏列表里面的数据没有这个字段，先以这种方式区分一下了。
            if(star == nil){
                imageStar.image = #imageLiteral(resourceName: "icon_collect_yes")
            }else{
                
                imageStar.image = star == true ? #imageLiteral(resourceName: "icon_collect_yes") : #imageLiteral(resourceName: "icon_collect_no")
            }
            
            
        }
    }
    
}



