//
//  TODOListStorage.swift
//  TODOList
//
//  Created by zhuo on 2017/7/31.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TODOListStorage: NSObject {
    
    let textType = "text";
    let imageType = "image";
    let audioType = "audio";
    var token : NotificationToken!
    var dbChangeCallback : ((RealmCollectionChange<Results<TODOTask>>) -> Void)!
    static let sharedStorage = TODOListStorage();
    private override init() {
        super.init();
    }
    static func storage() {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.TODOListZhuo");
        let targetURL = containerURL?.appendingPathComponent("Library/Caches/TODOListDatabase.realm");
        print(targetURL!);
        var configuration = Realm.Configuration();
        configuration.fileURL = targetURL;
        Realm.Configuration.defaultConfiguration = configuration;
        let _ =  try! Realm();
    }
    
    func addTask(task: TODOTask) {
        let realm = try! Realm();
        try! realm.write {
            realm.add(task);
        }
    }
    
    func removeTask(task: TODOTask)  {
        let realm = try! Realm();
        try! realm.write {
            realm.delete(task);
        }
    }
    
    func modifyTask(task: TODOTask, value:[String:Any]) {
        let realm = try! Realm();
        try! realm.write {
            realm.create(TODOTask.self, value: value, update: true);
        }
    }
    
    func refreshTask(task: TODOTask) {
        let realm = try! Realm();
        try! realm.write {
            realm.add(task, update: true);
        }

    }
    
   func fetchAllTasks() -> Results<TODOTask> {
        let realm = try! Realm();
        let reslutArr = realm.objects(TODOTask.self).sorted(byKeyPath:"createdAt", ascending:false);
        token =  reslutArr.addNotificationBlock { [weak self](changes: RealmCollectionChange) in
            guard let callback = self?.dbChangeCallback else{return;}
            callback(changes);
        }
        return reslutArr;
    }
}
