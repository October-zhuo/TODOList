//
//  TodayViewController.swift
//  TODOListExtension
//
//  Created by zhuo on 2017/8/6.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit
import Realm
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dataList : Results<TODOTask>!;
    let storage = TODOListStorage.sharedStorage;
    override func viewDidLoad() {
        super.viewDidLoad()
        TODOListStorage.storage();
        dataList = TODOListStorage.sharedStorage.fetchAllTasks();
        self.tableView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
        }
        self.tableView.isUserInteractionEnabled = true
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "删除") { (action, index) in
            let task = self.dataList[index.row];
            self.storage.removeTask(task: task);
        }
        deleteAction.backgroundColor = UIColor.colorWithHexString(hex: "0xdb5a6b");
        
        let fixAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "标记完成") { (action, index) in
            let task = self.dataList[index.row];
            self.storage.modifyTask(task: task, value: ["createdAt":task.createdAt!,"isDone":true])
        }
        fixAction.backgroundColor = UIColor.colorWithHexString(hex: "0x7b8a85");
        return [deleteAction,fixAction];
    }

}
