//
//  DateExtensions.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/14.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//(Swift版本扩展)前缀 sf

import UIKit

public extension Date {
    /**时间戳(毫秒)*/
    static var sf_getMilliSeconds: TimeInterval { //milliseconds
        get { return Date().timeIntervalSince1970 * 1000 }
    }
    
    /**当前时间戳(秒)*/
   static var sf_getCurrentTimeStamp: TimeInterval {
       get {
           return Date().timeIntervalSince1970
       }
   }
    
    /// 获取当前时间戳(秒)
    static func sf_getCurrentStamp() -> Int {
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    

}

public extension Date {
    /// 格式化当前日期（如yyyy-MM-dd HH:mm:ss、yyyy年MM月dd日 HH:mm:ss组合）
    func sf_getCurrentDate(format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: Date())
    }
    
    /// 年
    func sf_getYear() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    /// 月
    func sf_getMonth() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    /// 日
    func sf_getDay() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    /// 周
    func sf_getWeekDay() -> Int {
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval / 86400)
        let weekday = ((days + 4) % 7 + 7) % 7
        return weekday == 0 ? 7 : weekday
    }
    
    /// 是否是今天
    func sf_isToday() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    
    /// 日期转日期字符串
    static func sf_dateToDateString(date:Date, dateFormat:String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        
        let date = formatter.string(from: date)
        return date
    }
    
    /// 日期字符串转日期
    static func sf_dateStringToDate(dateStr: String, dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    /// 计算天数差
    static func sf_dateDifference(dateA: Date, dateB: Date) -> Double {
        let interval = dateA.timeIntervalSince(dateB)
        return interval / 86400
    }
    
    /// 比较时间先后
    static func sf_compareOneDay(oneDay: Date, anotherDay: Date) -> Int {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr:String = dateFormatter.string(from: oneDay)
        let anotherDayStr:String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result:ComparisonResult = (dateA?.compare(dateB!))!
        
        if (result == ComparisonResult.orderedDescending) {
            return 1
        }
        else if (result == ComparisonResult.orderedAscending) {
            return 2
        }
        else {
            return 0
        }
    }
    
    /// 刚刚,几分钟前,几小时前,天前,月前,年前
    func sf_getCompareCurrentTime(dateStr: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        let timeDate = dateFormatter.date(from: dateStr)!
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        var result:String = ""
        if timeInterval / 60 < 1 {
            result = "刚刚"
        } else if (timeInterval / 60) < 60 {
            temp = timeInterval / 60
            result = "\(Int(temp))分钟前"
        } else if timeInterval / 60 / 60 < 24 {
            temp = timeInterval / 60 / 60
            result = "\(Int(temp))小时前"
        } else if timeInterval / (24 * 60 * 60) < 30 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        } else if timeInterval / (30 * 24 * 60 * 60)  < 12 {
            temp = timeInterval / (30 * 24 * 60 * 60)
            result = "\(Int(temp))个月前"
        } else{
            temp = timeInterval / (12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
    
    /// 获取日期前后多少天的数据 (年,月,日,周)
    static func sf_getTotalDate(date: Date, length: NSInteger, reduce: Bool) -> [(String, String, String, String)] {
        var year = date.sf_getYear()
        var month = date.sf_getMonth()
        var day = date.sf_getDay()
        var week = date.sf_getWeekDay()
        
        var resultArray = [(String, String, String, String)]()
        
        reduce ? reduceDateADD(year: &year, month: &month, day: &day, week: &week, length: length, resultArray: &resultArray) : coverDateADD(year: &year, month: &month, day: day, week: &week, length: length, resultArray: &resultArray)
        return resultArray
    }
    
    private static func coverDateADD(year: inout Int, month: inout Int, day: Int, week: inout Int, length: Int, resultArray: inout [(String, String, String, String)]) {
        var monthDayLength = 31
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            monthDayLength = 31
            break
        case 4, 6, 9, 11:
            monthDayLength = 30
            break
        case 2:
            if (year % 100 != 0 && year % 4 == 0) || (year % 100 == 0 && year % 400 == 0) {
                monthDayLength = 29
            } else {
                monthDayLength = 28
            }
            break
        default: break
        }
        
        for index in day...monthDayLength {
            resultArray.append(("\(year)", "\(month)", "\(index)", "\(week)"))
            
            week += 1
            week = week == 7 ? 0 : week
            if resultArray.count >= length { return }
        }
        
        month += 1
        if month == 13 {
            month = 1
            year += 1
        }
        
        coverDateADD(year: &year, month: &month, day: 1, week: &week, length: length, resultArray: &resultArray)
    }
    
    private static func reduceDateADD(year: inout Int, month: inout Int, day: inout Int, week: inout Int, length: Int, resultArray: inout [(String, String, String, String)]) {
        for index in (1...day).reversed() {
            resultArray.append(("\(year)", "\(month)", "\(index)", "\(week)"))
            
            week -= 1
            week = week == -1 ? 6 : week
            if resultArray.count >= length { return }
        }
        
        month -= 1
        if month == 0 {
            year -= 1
            month = 12
        }
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            day = 31
            break
        case 4, 6, 9, 11:
            day = 30
            break
        case 2:
            if (year % 100 != 0 && year % 4 == 0) || (year % 100 == 0 && year % 400 == 0) {
                day = 29
            } else {
                day = 28
            }
            break
        default: break
        }
        
        reduceDateADD(year: &year, month: &month, day: &day, week: &week, length: length, resultArray: &resultArray)
    }
}





public extension Date {
/**
   处理会话列表时间：刚刚,几分钟前,几小时前,几天前,几月前,几年前
*/
    static func sf_getTimeAgoSinceDate(_ date: Date) -> String {
         
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
    static func sf_getChatTimeString(date: Date) -> String {
        
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
                let format = String(format: "'%@' HH:mm", date.sf_week())
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

public extension Date {
    // 获取当前时区的时间
    func sf_localeDate() -> Date {
        let localeTimezone = TimeZone.current
        let seconds = TimeInterval(localeTimezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func sf_week() -> String {
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "en")//ar-sa
            let weekday = calendar.component(.weekday, from: self) - 1
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en")//ar-sa
            return dateFormatter.weekdaySymbols[weekday]
        }
}
