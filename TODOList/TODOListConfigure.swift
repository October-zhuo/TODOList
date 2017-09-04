//
//  TODOListConfigure.swift
//  TODOList
//
//  Created by zhuo on 2017/6/13.
//  Copyright © 2017年 zhuo. All rights reserved.
// 
let kStatusLabelTag = 1001;
let kNameLabelTag = 1002;

let dateSeperater = "++"
let dateFormatingString = "M月d日\(dateSeperater)HH:mm";

import UIKit

extension TODOListController{
    
    
    func configureListCell(cell:TODOListTableViewCell, task:TODOTask)  {
        if task.taskType == "audio" {
           cell.nameLabel.text = "[音频]";
        }else if task.taskType == "image"{
            cell.nameLabel.text = "[图片]";
        }else{
            cell.nameLabel.text = task.text;
        }
        
        //statusLabel
        if task.isDone {
            cell.statusLabel.text = "✓";
        }else{
            cell.statusLabel.text = "";
        }

        //timeLabel
        let date = DateStringConverter.shared.dateFromString(originString: task.createdAt!);
        if let time : Date = date {
            let tempString = timeFactoryMethod(time: time);
            cell.timeLable.text = "\(tempString)";
        }else{
            cell.timeLable.text = "╮(╯▽╰)╭哎";
        }
        
    }
        
    fileprivate func timeFactoryMethod(time:Date) ->  String{
        let dateFormatter : DateFormatter = DateFormatter();
        dateFormatter.dateFormat = dateFormatingString;
        let timeString = dateFormatter.string(from: time);
        let timeArray = timeString.components(separatedBy: dateSeperater);
        if isToday(date: time) {
            return timeArray.last!;
        }else{
            return timeArray.first!;
        }
    }
    
    fileprivate func isToday(date:Date) -> Bool{
        let dateNow = Date.init(timeIntervalSinceNow: 0);
        let calendar = Calendar.current;
        let components1 = calendar.dateComponents([.year,.month,.day], from: dateNow);
        let components2 = calendar.dateComponents([.year,.month,.day], from: date);
        if components1.year == components2.year && components1.month == components2.month && components1.day == components2.day {
            return true;
        }else{
            return false;
        }
    }
}
