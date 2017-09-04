//
//  TODODetailTaskStatusCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailTaskStatusCell: UITableViewCell {
    
    fileprivate lazy var nameLabel = UILabel();
    fileprivate lazy var statusSwitch = UISwitch();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        self.contentView.addSubview(nameLabel);
        self.contentView.addSubview(statusSwitch);
        
        nameLabel.text = "任务状态";
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.statusSwitch.snp.left);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }
        
        statusSwitch.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
        }
        
    }
}
