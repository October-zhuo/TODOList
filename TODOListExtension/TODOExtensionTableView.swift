//
//  TODOExtensionTableView.swift
//  TODOList
//
//  Created by zhuo on 2017/8/6.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import UIKit

let kTodayViewControllerCellID = "kTodayViewControllerCellID";

extension TodayViewController : UITableViewDataSource{
    @available(iOSApplicationExtension 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count; //>= 3 ? 3 : dataList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kTodayViewControllerCellID) as? TODOListTableViewCell;
        if cell == nil {
           cell = TODOListTableViewCell.init(style: .default, reuseIdentifier: kTodayViewControllerCellID);
        }
        let task = dataList[indexPath.row] ;
        cell?.configureListCell(task: task);
        return cell!;
    }
}
