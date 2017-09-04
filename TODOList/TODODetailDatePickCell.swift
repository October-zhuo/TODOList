//
//  TODODetailDataPickCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailDatePickCell:  UITableViewCell{
    fileprivate lazy var dateLabel = UILabel();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        self.contentView.addSubview(dateLabel);
        dateLabel.text = "选择截止日期";
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }
    }
}
