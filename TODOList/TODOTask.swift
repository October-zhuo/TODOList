//
//  TODOTask.swift
//  TODOList
//
//  Created by zhuo on 2017/6/24.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TODOImage: Object {
    dynamic var imageWidth = 0;
    dynamic var imageHeight = 0;
    dynamic var imageName : String = "";
}

class TODOTask: Object{
    dynamic var taskType : String? = nil;
    dynamic var isDone : Bool = false;
    dynamic var createdAt : String? = nil;
    dynamic var expiredAt : Date? = nil;
    dynamic var audioName : String = "";
    dynamic var text : String? = nil;
    let imageList = List<TODOImage>();
    
    override static func primaryKey() -> String{
        return "createdAt";
    }
    
    static func copyFromOtherTask(originTask: TODOTask) ->  TODOTask{
        let task = TODOTask();
        task.audioName = (originTask.audioName);
        task.createdAt = originTask.createdAt;
        task.expiredAt = originTask.expiredAt;
        for image in originTask.imageList {
                task.imageList.append(image);
            }
        task.isDone = (originTask.isDone);
        task.taskType = originTask.taskType;
        task.text = originTask.text;
        return task;
    }
}

