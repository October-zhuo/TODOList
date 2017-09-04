//
//  TODOListDetailViewController.swift
//  TODOList
//
//  Created by zhuo on 2017/6/14.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

public let TODODetailDatePickCellID = "TODODetailDatePickCellID";
public let TODODetailTaskStatusCellID = "TODODetailTaskStatusCellID";
public let TODODetailCofigureCellID = "TODODetailCofigureCellID";
public let TODODetailTextCellID = "TODODetailTextCellID"
public let TODODetailImageCellID = "TODODetailImageCellID"
public let TODODetailAudioCellID = "TODODetailAudioCellID"
let TODODetailHeaderViewID = "TODODetailHeaderViewID"

class TODOListDetailViewController: UIViewController {

    var tableView : UITableView!
    var sureButton : UIButton!
    var task : TODOTask!
    var isEdit : Bool!
        init(originTask: TODOTask?) {
        super.init(nibName: nil, bundle: nil);
            if originTask == nil{
                task = TODOTask();
                isEdit = false;
            }else{
                isEdit = true;
                if let tempTask = originTask {
                    task = TODOTask.copyFromOtherTask(originTask: tempTask);
                }else{
                    task = TODOTask();
                    isEdit = false;
                }
            }
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        setupUI();
        configureTabelviewCell();
    }
    
    fileprivate func setupUI() {
        self.title = isEdit == true ? "任务详情":"添加任务";
        
        let left = UIBarButtonItem.init(image: UIImage.init(named: "nav_back"), style: .plain, target: self, action: #selector(didClickBackItem));
        left.tintColor = UIColor.gray;
        navigationItem.leftBarButtonItem = left;
        
        sureButton = UIButton.init(frame: .zero);
        sureButton.backgroundColor = UIColor.colorWithHexString(hex: "0x27a59c");
        sureButton.setTitle("完成", for: .normal);
        sureButton.setTitleColor(.white, for: .normal);
        sureButton.addTarget(self, action: #selector(didClickSureBtn), for: .touchUpInside);
        self.view.addSubview(sureButton);
        sureButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(50);
        }
        
        tableView = UITableView.init(frame: .zero);
        tableView.separatorStyle = .none;
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView);
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.sureButton.snp.top);
        }
    }

    func configureTabelviewCell() {
        tableView.register(TODODetailCofigureCell.self, forCellReuseIdentifier: TODODetailCofigureCellID);
        tableView.register(TODODetailDatePickCell.self, forCellReuseIdentifier: TODODetailDatePickCellID);
        tableView.register(TODODetailTaskStatusCell.self, forCellReuseIdentifier: TODODetailTaskStatusCellID);
        tableView.register(TODODetailHeaderView.self, forHeaderFooterViewReuseIdentifier: TODODetailHeaderViewID);
        tableView.register(TODODetailTextCell.self, forCellReuseIdentifier: TODODetailTextCellID);
        tableView.register(TODODetailImageCell.self, forCellReuseIdentifier: TODODetailImageCellID);
        tableView.register(TODODetailAudioCell.self, forCellReuseIdentifier: TODODetailAudioCellID);
    }
    
    @objc func didClickSureBtn(){
        removeObserverIfNeed();
        if isEdit{
            TODOListStorage.sharedStorage.refreshTask(task: task);
            navigationController?.popViewController(animated: true);
        }else{
            if task.audioName.characters.count <= 0  && task.imageList.count <= 0 && task.text == nil {
                let alert = UIAlertController.init(title: "╮(╯▽╰)╭", message: "来了，不留下点什么？", preferredStyle: .alert);
                let sureAction = UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                    
                });
                alert.addAction(sureAction);
                self.navigationController?.present(alert, animated: true, completion: nil);
            }else {
                let date = Date();
                task.createdAt = DateStringConverter.shared.stringFromDate(originDate: date, formatterString: "yyyy-MM-dd HH:mm:ss");
                TODOListStorage.sharedStorage.addTask(task: task);
                navigationController?.popViewController(animated: true);
            }
        }
    }
    
    @objc func didClickBackItem() {
        removeObserverIfNeed();
        self.navigationController?.popViewController(animated: true);
    }
}

// //MARK:- tableview delegate
extension TODOListDetailViewController : UITableViewDelegate{
    
}


