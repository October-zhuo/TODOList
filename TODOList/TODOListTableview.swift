//
//  TODOListTableview.swift
//  TODOList
//
//  Created by zhuo on 2017/6/13.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit

extension TODOListController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TODOListTableViewCell = tableview.dequeueReusableCell(withIdentifier: kTODOListCellID, for:indexPath) as! TODOListTableViewCell ;
        let task = dataList[indexPath.row] ;
        cell.configureListCell(task: task);
        return cell;
    }
}
