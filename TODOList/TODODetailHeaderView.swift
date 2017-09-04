//
//  TODODetailHeaderView.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit
class TODODetailHeaderView:  UITableViewHeaderFooterView{
    fileprivate lazy var titleLabel = UILabel();
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
        self.addSubview(titleLabel);
        titleLabel.textAlignment = NSTextAlignment.center;
        titleLabel.font = UIFont.systemFont(ofSize: 26);
        titleLabel.textColor = UIColor.darkText;
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshTitle(title:String)  {
        self.titleLabel.text = title;
    }
}
