//
//  TODODetailDataPickCell.swift
//  TODOList
//
//  Created by zhuo on 2017/6/27.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailDatePickCell:  UITableViewCell, TODODetailListCellProtocol{
    var myTask : TODOTask!;
    fileprivate lazy var titleLabel = UILabel();
    fileprivate lazy var dateFeild = UITextField();
    fileprivate lazy var datePicker : UIDatePicker = {
        let dateP = UIDatePicker.init(frame:  CGRect(x:0,y:0,width:375,height:200))
        dateP.locale = Locale.init(identifier: "zh_CN");
        dateP.backgroundColor = .lightGray;
        //设置样式，当前设为同时显示日期和时间
        dateP.datePickerMode = .date;
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        dateP.minimumDate = Date();
        dateP.maximumDate = Date().addingTimeInterval(60*60*24*365*10);
        // 设置默认时间
        dateP.date = Date()
        return dateP;
    }();

    func loadTask(task: TODOTask) {
        myTask = task;
        if  let expireDate =  task.expiredAt {
              dateFeild.text = DateStringConverter.shared.stringFromDate(originDate: expireDate, formatterString: "yyyy-MM-dd")
        }
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
        self.contentView.addSubview(titleLabel);
        titleLabel.text = "选择截止日期";
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20);
            make.width.equalTo(150);
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
        }
        
        dateFeild.textAlignment = .right;
        self.contentView.addSubview(dateFeild);
        dateFeild.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.left.equalTo(self.titleLabel.snp.right);
        }
        dateFeild.inputView = datePicker;
        let toolBar = UIToolbar(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:30));
        toolBar.barStyle = .default;
        let doneItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(didClickDoneItem));
        let cancleItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(didClickCancleItem));
        let flexItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil);
        toolBar.items = [cancleItem,flexItem, doneItem];
        dateFeild.inputAccessoryView = toolBar;
        
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
    
    @objc func didClickDoneItem() {
        dateFeild.text = DateStringConverter.shared.stringFromDate(originDate: datePicker.date, formatterString: "yyyy-MM-dd")
        myTask.expiredAt = datePicker.date;
        dateFeild.resignFirstResponder();
    }
    
    @objc func didClickCancleItem() {
        dateFeild.resignFirstResponder();
    }
}
