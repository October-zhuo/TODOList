//
//  TODOListDetailTableview.swift
//  TODOList
//
//  Created by zhuo on 2017/6/24.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit

let TODOListDetailViewCellTextID = "TODOListDetailViewCellTextID";
let TODOListDetailViewCellImageID = "TODOListDetailViewCellImageID";
let TODOListDetailViewCellAudioID = "TODOListDetailViewCellAudioID";

let textType = "text";
let imageType = "image";
let audioType = "audio";
let headerViewHeight : CGFloat = 50;

extension TODOListDetailViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0;
        
        switch section {
        case 0:
            cellCount = 1;
            break ;
        case 1:
            cellCount = 2;
            break;
        default:
            break;
        }
        return cellCount;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.task.taskType == textType {
                 let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailTextCellID) as! TODODetailTextCell;
                cell.endEditCallback = {(result: String) in
                    self.task.text = result;
                }
                cell.loadTask(task: task);
                return cell;
            }else if self.task.taskType == imageType {
                let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailImageCellID) as! TODODetailImageCell;
                cell.loadTask(task: task);
                return cell;
            }else if self.task.taskType == audioType {
                let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailAudioCellID) as! TODODetailAudioCell;
                cell.loadTask(task: task);
                return cell;
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailCofigureCellID) as! TODODetailCofigureCell;
                cell.clickBtnCallback = {(button:UIButton)->Void in
                    if button.tag == 1000 {
                         self.task.taskType = textType;
                    }else if button.tag == 1001{
                        self.task.taskType = imageType;
                    }else if button.tag == 1002{
                        self.task.taskType = audioType;
                    }
                    tableView.reloadData();
                }
                return cell;
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailTaskStatusCellID) as! TODODetailTaskStatusCell;
                cell.loadTask(task: task);
                return cell;
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TODODetailDatePickCellID) as! TODODetailDatePickCell;
                 cell.loadTask(task: task);
                return cell;
            default:
                return UITableViewCell();
            }
        default:
            return UITableViewCell();
        }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       var headerVeiw = tableView.dequeueReusableHeaderFooterView(withIdentifier: TODODetailHeaderViewID) as? TODODetailHeaderView;
        if headerVeiw == nil {
            headerVeiw = TODODetailHeaderView.init(reuseIdentifier:TODODetailHeaderViewID);
        }
        return headerVeiw;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120;
        }else{
            return 60;
        }
    }
    
    func removeObserverIfNeed() {
        if  let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? TODODetailImageCell{
            cell.removeAllObservers();
        }
    }
}
