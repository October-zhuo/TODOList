//
//  ViewController.swift
//  TODOList
//
//  Created by zhuo on 2017/6/12.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Realm

let kTODOListCellID = "kTODOListCellID";

class TODOListController: UIViewController,UITableViewDelegate {
    
    var tableview : UITableView!;
    var addButton : UIButton!;
    var dataList : Results<TODOTask>!;
    var storage = TODOListStorage();
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        dataList =  storage.fetchAllTasks();
        storage.dbChangeCallback = {(changes: RealmCollectionChange) -> Void in
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

        
//
//        let realm = try! Realm();
//       let result =  realm.objects(Dog.self);
//        print(result);
//        
//       TODOItems.asObservable().subscribe(onNext: { [weak self] items in
//            self?.refreshUI();
//       }, onError: { (error) in
//            print(error);
//       }, onCompleted: {
//            print("complete");
//       }, onDisposed: {
//            print("dispose");
//       }).addDisposableTo(bag);
//        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        loadTODOItems();
    }
    
    fileprivate func setupUI(){
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isTranslucent = false;
        //configure tableview
        tableview = UITableView();
        tableview.delegate = self ;
        tableview.dataSource = self;
        self.view.addSubview(tableview);
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-50);
        }
        tableview.backgroundView = UIImageView.init(image: UIImage.init(named: "tableviewBG"));
        tableview.register(TODOListTableViewCell.self, forCellReuseIdentifier: kTODOListCellID)
        
        //configure addbtn
        addButton = UIButton();
        addButton.backgroundColor = UIColor.lightGray;
        addButton.setTitle("添加", for: UIControlState.normal);
        self.view.addSubview(addButton);
//        addButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                let controller = TODOListDetailViewController();
//                controller.title = "Add Item";
//                controller.todo.asObservable().subscribe(onNext: { [weak self] item in
//                    self?.TODOItems.value.append(item);
//                    self?.saveTODOItems();
//                }).addDisposableTo((self?.bag)!);
//                self?.navigationController?.pushViewController(controller, animated: true);
//            })
//            .disposed(by: bag)
        addButton.addTarget(self, action: #selector(didClickAddButton), for: .touchUpInside);
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.equalTo(50);
        }
    }
    
    @objc private func didClickAddButton(){
        let controller = TODOListDetailViewController.init(originTask: nil);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
//    fileprivate func refreshUI(){
//        tableview.reloadData();
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navigation = segue.destination as! UINavigationController;
//        let controller = navigation.topViewController as! TODOListDetailViewController;
//        
//        if segue.identifier == "add" {
//            controller.title = "Add Item";
//            controller.todo.asObservable().subscribe(onNext: { [weak self] item in
//                self?.TODOItems.value.append(item);
//                self?.saveTODOItems();
//            }).addDisposableTo(bag);
//            
//        }else if (segue.identifier == "modify"){
//            if let index = tableview.indexPath(for: sender as! UITableViewCell) {
//                let item = TODOItems.value[index.row];
//                let testTask = TODOTask();
//                testTask.taskType = .text;
//                testTask.taskDetail = "1242412343";
//                testTask.taskIsDone = false;
//                item.taskList = [testTask];
//                controller.item = item;
//                
//                controller.todo.asObservable().subscribe(onNext: { [weak self] item in
//                    self?.TODOItems.value[index.row] = item;
//                }).addDisposableTo(bag);
//            }
//          
//            controller.title = "Modify Item";
//        }
//    }
//}

//MARK:- tableview delegate method


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataList[indexPath.row];
        let nextController = TODOListDetailViewController.init(originTask: task);
        navigationController?.pushViewController(nextController, animated: true);
        tableView.deselectRow(at: indexPath, animated: false);
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "删除") { (action, index) in
            let task = self.dataList[index.row];
            self.storage.removeTask(task: task);
        }
        deleteAction.backgroundColor = .red;

        let fixAction:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "标记完成") { (action, index) in
            let task = self.dataList[index.row];
            self.storage.modifyTask(task: task, value: ["createdAt":task.createdAt!,"isDone":true])
        }
        fixAction.backgroundColor = .green;
        return [deleteAction,fixAction];
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }

}



