//
//  HotTextLabelCellCollectionViewCell.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/9/7.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class HotTextLabelCell: UICollectionViewCell {
    
    
    var textLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white;
        l.backgroundColor = UIColor.clear;
        l.font = UIFont.init(descriptor: UIFontDescriptor.init(), size: 13.0)
        l.textAlignment = .center;
        return l;
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let att = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        let string:NSString = textLabel.text! as NSString
        
        var newFram = string.boundingRect(with: CGSize(width:  textLabel.bounds.size.width, height: textLabel.bounds.size.height), options: .usesLineFragmentOrigin, attributes: [
            NSAttributedStringKey.font : textLabel.font
            ], context: nil)
        
        newFram.size.height += 12;
        newFram.size.width += 12;
        att.frame = newFram;
        
        return att;
        
    }
    
    
    
    
}


extension HotTextLabelCell{
    
    func setUI() {
        
        self.addSubview(textLabel);
        
        textLabel.snp.makeConstraints { (maker) in
            
            maker.left.equalToSuperview().offset(0);
            maker.right.equalToSuperview().offset(0);
            maker.bottom.equalToSuperview().offset(0);
            maker.top.equalToSuperview().offset(0);
            //            maker.height.equalTo(self.size.height/2);
            
        }
    }
    
}


