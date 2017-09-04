//
//  TODODetailTextCell.swift
//  TODOList
//
//  Created by zhuo on 2017/8/2.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailTextCell: UITableViewCell, UITextViewDelegate, TODODetailListCellProtocol {
    var textView : UITextView!;
    var myTask : TODOTask!;
    
    var endEditCallback : ((_ result : String) -> Void)!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        let toolBar = UIToolbar(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:30));
        toolBar.barStyle = .default;
        let doneItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(didClickDoneItem));
        let cancleItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(didClickDoneItem));
        let flexItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil);
        toolBar.items = [cancleItem,flexItem, doneItem];
        textView = UITextView();
        textView.delegate = self;
        textView.font = UIFont.systemFont(ofSize: 16);
        textView.backgroundColor = UIColor.colorWithHexString(hex: "0xcccccc");
        textView.inputAccessoryView = toolBar;
        self.contentView.addSubview(textView);
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView);
        }
    }
    
    func loadTask(task: TODOTask) {
        myTask = task;
        self.textView.text = task.text;
    }
    
    func removeAllObservers() {
        
    }
    
    @objc fileprivate func didClickDoneItem(){
        self.textView.resignFirstResponder();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder();
        if self.endEditCallback != nil{
            self.endEditCallback(textView.text);
        }
    }
}
