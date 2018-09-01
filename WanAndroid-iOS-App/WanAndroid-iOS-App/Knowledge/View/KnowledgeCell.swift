//
//  KnowledgeCell.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/30.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class KnowledgeCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    
    
    var itemData : [String : Any]? {
        didSet {
            labelTitle?.text = itemData?["name"] as? String
            labelTitle.textColor = COLOR_TEXT_GREEN
            
            let childrens =  itemData?["children"] as? [Any]
            var subString = ""
            childrens?.forEach({ (item) in
                let data = item as? [String : Any]
                subString.append((data?["name"] as! String) + "   ")
            })
            
            labelSubtitle?.text = subString
        }
    }

}
