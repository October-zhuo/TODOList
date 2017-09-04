//
//  ViewController.swift
//  TODOList
//
//  Created by zhuo on 2017/6/12.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

let kTODOListCellID = "kTODOListCellID";

class TODOListController: UIViewController,UITableViewDelegate {
    
    var tableview : UITableView!;
    var addButton : UIButton!;
    var dataList : Results<TODOTask>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        dataList =  TODOListStorage.sharedStorage.fetchAllTasks();
        TODOListStorage.sharedStorage.dbChangeCallback = {(changes: RealmCollectionChange) -> Void in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self.tableview.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                self.tableview.beginUpdates()
                self.tableview.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self.tableview.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                self.tableview.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self.tableview.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
        }
      }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupUI(){
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isTranslucent = false;
        self.title = "任务列表";
        
        //configure tableview
        tableview = UITableView();
        tableview.delegate = self ;
        tableview.dataSource = self;
        self.view.addSubview(tableview);
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
        tableview.separatorStyle = .none;
        tableview.backgroundColor = UIColor.colorWithHexString(hex: "0xefeff4");
        tableview.register(TODOListTableViewCell.self, forCellReuseIdentifier: kTODOListCellID)
        
        //configure addbtn
        addButton = UIButton();
        addButton.setImage(UIImage.init(named: "add_task"), for: .normal);
        addButton.layer.masksToBounds = true;
        addButton.layer.cornerRadius = 40;
        self.view.addSubview(addButton);
        addButton.addTarget(self, action: #selector(didClickAddButton), for: .touchUpInside);
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-20);
            make.centerX.equalTo(self.view);
            make.height.equalTo(80);
            make.width.equalTo(80);
        }
    }
    
    @objc private func didClickAddButton(){
        let controller = TODOListDetailViewController.init(originTask: nil);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataList[indexPath.row];
        let nextController = TODOListDetailViewController.init(originTask: task);
        navigationController?.pushViewController(nextController, animated: true);
        tableView.deselectRow(at: indexPath, animated: false);
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "删除") { (action, index) in
            let task = self.dataList[index.row];
            TODOListStorage.sharedStorage.removeTask(task: task);
        }
        deleteAction.backgroundColor = UIColor.colorWithHexString(hex: "0xdb5a6b");

        let fixAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "标记完成") { (action, index) in
            let task = self.dataList[index.row];
            TODOListStorage.sharedStorage.modifyTask(task: task, value: ["createdAt":task.createdAt!,"isDone":true])
        }
        fixAction.backgroundColor = UIColor.colorWithHexString(hex: "0x7b8a85");
        return [deleteAction,fixAction];
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
}
