//
//  DateExtensions+ChatTime.swift
//  SwiftProject
//
//  Created by daixingchuang on 2021/6/23.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//

import Foundation

extension Date {
    /**时间戳(毫秒)*/
    static var getMillTime: TimeInterval { //milliseconds
        get { return Date().timeIntervalSince1970 * 1000 }
    }
    
    /**当前时间戳(秒)*/
   static var getCurrentTimeStamp: TimeInterval {
       get {
           return Date().timeIntervalSince1970
       }
   }

}


extension Date {
/**
   处理会话列表时间：刚刚,几分钟前,几小时前,几天前,几月前,几年前
*/
    static func getTimeAgoSinceDate(_ date: Date) -> String {
         
            var calendar = Calendar.current
            calendar.locale = Locale.init(identifier: "en")
        
            let now = Date()
        
            let earliest = (now as NSDate).earlierDate(date)
            let latest = (earliest == now) ? date : now
          
            let components: DateComponents = calendar.dateComponents(
                [
                    .second,
                    .minute,
                    .hour,
                    .day,
                    .weekOfYear,
                    .month,
                    .year
                ],
                from: earliest,
                to: latest)
            if (components.year! >= 2) {
                //message_year_ago
                return String(format: "message_year_ago", "\(components.year!)")
            } else if (components.year! >= 1){
                return "message_lastyear"
            } else if (components.month! >= 2) {
                return String(format:"message_month_ago",  "\(components.month!)")
            } else if (components.month! >= 1){
                return "message_lastmonth"
            } else if (components.weekOfYear! >= 2) {
                return String(format: "message_weekago", "\(components.weekOfYear!)")
            } else if (components.weekOfYear! >= 1){
                return "message_lastweek"
            } else if (components.day! >= 2) {
                return String(format: "message_dayago", "\(components.day!)")
            } else if (components.day! >= 1){
                return "message_yesterday"
            } else if (components.hour! >= 1) {
                return String(format: "message_hourago", "\(components.hour!)")
            } else if (components.minute! >= 1) {
                return String(format: "message_minuteago", "\(components.minute!)")
            } else if (components.second! >= 3) {
                return String(format: "message_secondago", "\(components.second!)")
            } else {
                return "message_justnow"
            }
        }
    
    /**处理聊天时间()*/
    static func getChatTimeString(date: Date) -> String {
        
        var calendar = Calendar.current
        calendar.locale = Locale.init(identifier: "en")
        
        let now = Date()
        let units: Set<Calendar.Component> = [.year, .month, .day]
        let nowComponents =  calendar.dateComponents(units, from: now)
        let targetComponents =  calendar.dateComponents(units, from: date)
        
        let year = nowComponents.year! - targetComponents.year!
        let month = nowComponents.month! - targetComponents.month!
        let day = nowComponents.day! - targetComponents.day!
        
        let localeFormatter = DateFormatter()
        localeFormatter.locale =  Locale(identifier: "en")
        
        
        if year != 0 {
            localeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return localeFormatter.string(from: date)
        } else {
            if (month > 0 || day > 7) {
                localeFormatter.dateFormat = "MM-dd HH:mm"
                return localeFormatter.string(from: date)
            } else if (day > 1) {
                let format = String(format: "'%@' HH:mm", date.week())
                localeFormatter.dateFormat = format
                return localeFormatter.string(from: date)
            }  else if (day == 1) {
                let format = String(format: "'%@' HH:mm", "yday")
                localeFormatter.dateFormat = format
                return localeFormatter.string(from: date)
            } else if (day == 0){
                localeFormatter.dateFormat = "HH:mm"
                return localeFormatter.string(from: date)
            } else {
                return ""
            }
        }
    }

}

extension Date {
    // 获取当前时区的时间
    func localeDate() -> Date {
        let localeTimezone = TimeZone.current
        let seconds = TimeInterval(localeTimezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func week() -> String {
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "en")//ar-sa
            let weekday = calendar.component(.weekday, from: self) - 1
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en")//ar-sa
            return dateFormatter.weekdaySymbols[weekday]
        }
}
