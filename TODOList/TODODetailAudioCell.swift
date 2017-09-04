//
//  TODODetailAudioCell.swift
//  TODOList
//
//  Created by zhuo on 2017/8/2.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODODetailAudioCell: UITableViewCell, TODODetailListCellProtocol{

    var recordBtn : UIButton? = nil;
    var recorder = TODORecorder();
    func loadTask(task: TODOTask) {
    }
    
    func removeAllObservers() {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        recordBtn = UIButton();
        recordBtn?.backgroundColor = .orange;
        self.contentView.addSubview(recordBtn!);
        recordBtn?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.equalTo(150);
        })
       
        recordBtn?.addTarget(self, action: #selector(beginToRecord), for: .touchDown);
        recordBtn?.addTarget(self, action: #selector(stopToRecord), for: .touchUpInside);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func beginToRecord(){
        recorder.startRecord();
    }
    
    @objc func stopToRecord(){
        recorder.stopRecord();
    }
    
  }
