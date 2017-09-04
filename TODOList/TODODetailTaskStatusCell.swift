//
//  TODODetailTaskStatusCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailTaskStatusCell: UITableViewCell, TODODetailListCellProtocol {
    
    fileprivate lazy var nameLabel = UILabel();
    fileprivate lazy var statusSwitch = UISwitch();
    var myTask : TODOTask!;
    
    func loadTask(task: TODOTask) {
        myTask = task;
        statusSwitch.isOn = task.isDone;
    }
    
    func removeAllObservers() {
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        self.selectionStyle = .none;
        self.contentView.addSubview(nameLabel);
        self.contentView.addSubview(statusSwitch);
        
        statusSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged);
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
        
        let bottomLine = UIView();
        self.contentView.addSubview(bottomLine);
        bottomLine.backgroundColor = UIColor.colorWithHexString(hex: "0xcccccc");
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(0.5);
        };
    }
    
    @objc func switchDidChange() {
        myTask.isDone = statusSwitch.isOn;
    }
}
