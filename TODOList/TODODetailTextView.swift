//
//  TODODetailTextView.swift
//  TODOList
//
//  Created by zhuo on 2017/6/25.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
class TODODetailTextView : UIView {
    fileprivate var textLabel : UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        textLabel = UILabel.init(frame: .zero);
        self.addSubview(textLabel);
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TODODetailTextView : TODODetailViewProtocol{
    func loadItem(item: TODOTask) {
//        self.textLabel.text = item.taskDetail;
    }
}
