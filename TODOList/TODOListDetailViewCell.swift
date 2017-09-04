//
//  TODOListDetailViewCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/25.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit

class TODOListDetailViewCell: UITableViewCell {
    var innerView : UIView!;
    var statusImageView : UIImageView!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     init(style: UITableViewCellStyle, reuseIdentifier: String?, innerView: UIView) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.innerView = innerView;
        statusImageView = UIImageView.init(frame: .zero);
        self.contentView.addSubview(innerView);
        self.contentView.addSubview(statusImageView);
        statusImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(18);
            make.width.equalTo(18);
        }
        self.innerView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.left.equalTo(self.statusImageView.snp.right);
        }
    }

    
//TODO: creat layoutmanager view's layout & use layout file to layout.
    
    func loadItem(item:TODOTask) {
//        let innerview:TODODetailTextView = self.innerView as! TODODetailTextView;
//        innerView.loadItem(item);
    }
}
