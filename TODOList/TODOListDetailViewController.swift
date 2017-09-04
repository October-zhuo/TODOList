//
//  TODOListDetailViewController.swift
//  TODOList
//
//  Created by zhuo on 2017/6/14.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import Realm

let TODOListDetailViewCellID = "TODOListDetailViewCell";
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
    }
    
    fileprivate func setupUI(){
        sureButton = UIButton.init(frame: .zero);
        sureButton.backgroundColor = .orange;
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
        tableView.register(TODOListDetailViewCell.self, forCellReuseIdentifier: TODOListDetailViewCellID);
        tableView.register(TODODetailCofigureCell.self, forCellReuseIdentifier: TODODetailCofigureCellID);
        tableView.register(TODODetailDatePickCell.self, forCellReuseIdentifier: TODODetailDatePickCellID);
        tableView.register(TODODetailTaskStatusCell.self, forCellReuseIdentifier: TODODetailTaskStatusCellID);
        tableView.register(TODODetailHeaderView.self, forHeaderFooterViewReuseIdentifier: TODODetailHeaderViewID);
        tableView.register(TODODetailTextCell.self, forCellReuseIdentifier: TODODetailTextCellID);
        tableView.register(TODODetailImageCell.self, forCellReuseIdentifier: TODODetailImageCellID);
        tableView.register(TODODetailAudioCell.self, forCellReuseIdentifier: TODODetailAudioCellID);
        
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

    @objc func didClickSureBtn(){
        removeObserverIfNeed();
        if isEdit{
            TODOListStorage().refreshTask(task: task);
        }else{
 //MARK:- storage 单例
            let date = Date();
            task.createdAt = DateStringConverter.shared.stringFromDate(originDate: date);
            TODOListStorage().addTask(task: task);
        }
        navigationController?.popViewController(animated: true);
    }
}

// //MARK:- tableview delegate
extension TODOListDetailViewController : UITableViewDelegate{
    
}


