//
//  TODODetailListCellProtocol.swift
//  TODOList
//
//  Created by zhuo on 2017/8/5.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation

protocol TODODetailListCellProtocol {
    func loadTask(task: TODOTask);
    func removeAllObservers();
}
