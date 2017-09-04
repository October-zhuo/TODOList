//
//  TODODetailCofigureCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailCofigureCell: UITableViewCell {

    var clickBtnCallback :((_ button : UIButton) ->Void)!
    fileprivate lazy var textBtn = UIButton();
    fileprivate lazy var imageBtn = UIButton();
    fileprivate lazy var audioBtn  = UIButton();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        self.contentView.addSubview(textBtn);
        self.contentView.addSubview(imageBtn);
        self.contentView.addSubview(audioBtn);
        
        let width = UIScreen.main.bounds.size.width / 3.0;
        
        textBtn.setTitle("文字任务", for: UIControlState.normal);
        textBtn.backgroundColor = UIColor.colorWithHexString(hex: "0xe08e60");
        textBtn.tag = 1000;
        textBtn.addTarget(self, action: #selector(didClickButton), for: .touchUpInside);
        imageBtn.setTitle("图片任务", for: UIControlState.normal);
        imageBtn.backgroundColor = UIColor.colorWithHexString(hex: "0x3b7291");
        imageBtn.tag = 1001;
        imageBtn.addTarget(self, action: #selector(didClickButton), for: .touchUpInside);
        audioBtn.setTitle("音频任务", for: UIControlState.normal);
        audioBtn.backgroundColor = UIColor.colorWithHexString(hex: "0x96c1b7");
        audioBtn.tag = 1002;
        audioBtn.addTarget(self, action: #selector(didClickButton), for: .touchUpInside);
        
        textBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(width);
        }
        
        imageBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(width);
            make.top.equalTo(self.contentView);
        }
        
        audioBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(width);
            }
        
    }

    @objc func didClickButton(button: UIButton) {
        if (self.clickBtnCallback != nil) {
            self.clickBtnCallback(button);
        }
    }
}
