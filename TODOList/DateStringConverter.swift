//
//  DateStringConvert.swift
//  TODOList
//
//  Created by zhuo on 2017/8/5.
//  Copyright © 2017年 zhuo. All rights reserved.
//

import Foundation

class DateStringConverter: NSObject {
    static let shared = DateStringConverter();
    let formatter:DateFormatter! = DateFormatter();
    
    private override init() {
        super.init();
    }
    
    func dateFromString(originString: String, formatterString: String) -> Date? {
        formatter.dateFormat = formatterString;
        let date = formatter.date(from: originString);
        return date;
    }
    
   func stringFromDate(originDate:Date, formatterString: String) -> String? {
        formatter.dateFormat = formatterString;
        let resultString = formatter.string(from: originDate);
        return resultString;
    }
}
