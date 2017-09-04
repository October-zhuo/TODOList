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
    var statusLabel : UILabel!;
    var timeLable : UILabel!;
    var bottomLine : UIView!;
    
    
override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.clear;
        self.selectionStyle = .none;
    
        statusLabel = UILabel.init();
        statusLabel.font = UIFont.systemFont(ofSize: 25);
        contentView.addSubview(statusLabel);
        statusLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(30);
            make.width.equalTo(30);
        };
        
        timeLable = UILabel.init();
        contentView.addSubview(timeLable);
        timeLable.textAlignment = .right;
        timeLable.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(70);
        }
        
        nameLabel = UILabel.init();
        contentView.addSubview(nameLabel);
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(statusLabel.snp.right);
            make.right.equalTo(timeLable.snp.left);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        };
        timeLable.textColor = UIColor.init(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 1);
        bottomLine = UIView.init();
        contentView.addSubview(bottomLine);
        bottomLine.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3);
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(statusLabel);
            make.right.equalTo(contentView).offset(-15);
            make.bottom.equalTo(contentView);
            make.height.equalTo((1));
        };
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
