//
//  TODOListTableViewCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/12.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import SnapKit

class TODOListTableViewCell: UITableViewCell {
    var nameLabel : UILabel!;
    var  accery : UIImageView!;
    var statusLabel : UILabel!;
    var timeLable : UILabel!;
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.clear;
        
        statusLabel = UILabel.init();
        contentView.addSubview(statusLabel);
        statusLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(20);
            make.width.equalTo(20);
        };
        
        timeLable = UILabel.init();
        contentView.addSubview(timeLable);
        timeLable.textAlignment = .right;
        timeLable.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(100);
        }
        
        nameLabel = UILabel.init();
        contentView.addSubview(nameLabel);
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(statusLabel.snp.right);
            make.right.equalTo(timeLable.snp.left);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        };
        
        timeLable.textColor = UIColor.lightText;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
