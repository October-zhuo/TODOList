//
//  TODOAddImageTaskButton.swift
//  TODOList
//
//  Created by zhuo on 2017/8/5.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

class TODOAddImageTaskButton: UIButton {
    let kClearButtonH_W = 20;
    var clickClearButtonCallBack : ((_ button:TODOAddImageTaskButton) ->Void)!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        let clearButton = UIButton();
        self.addSubview(clearButton);
        clearButton.setImage(UIImage.init(named: "image_close"), for: .normal);
        clearButton.addTarget(self, action: #selector(didClickClearButton), for: .touchUpInside);
        clearButton.snp.makeConstraints { (make) in
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(kClearButtonH_W);
            make.width.equalTo(kClearButtonH_W);
        }
    }
    
    @objc func didClickClearButton(){
        if clickClearButtonCallBack != nil {
            clickClearButtonCallBack(self);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
