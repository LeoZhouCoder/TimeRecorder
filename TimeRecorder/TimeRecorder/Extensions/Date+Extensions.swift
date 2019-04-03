//
//  Date+Extensions.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import Foundation

public enum Weekday: Int {
    case sunday = 1
    case monday, tuesday, wednesday, thursday, friday, saturday
}

extension Date {
    
    static var todayMidnight: Date {
        let date = Date()
        return Date(calendar: date.calendar, timeZone: date.timeZone, era: date.era,
             year: date.year, month: date.month, day: date.day,
             hour: 0, minute: 0, second: 0, nanosecond: 0)
    }
    
    public var calendar: Calendar {
        return Calendar.current
    }
    
    public var timeZone: TimeZone {
        return self.calendar.timeZone
    }
    
    public var era: Int {
        return calendar.component(.era, from: self)
    }
    
    public var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: newValue, month: month, day: day,
                        hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    public var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    
    public var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: year, month: newValue, day: day,
                        hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    public var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    public var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    public var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    
    public var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: year, month: month, day: newValue,
                        hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    public var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: year, month: month, day: day,
                        hour: newValue, minute: minute, second: second, nanosecond: nanosecond)
        }
    }
    
    public var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: year, month: month, day: day,
                        hour: hour, minute: newValue, second: second, nanosecond: nanosecond)
        }
    }
    
    public var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era,
                        year: year, month: month, day: day,
                        hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }
    
    public var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }
    
    public var midnight: Date {
        return Date(calendar: self.calendar, timeZone: self.timeZone, era: self.era,
                    year: self.year, month: self.month, day: self.day,
                    hour: 0, minute: 0, second: 0, nanosecond: 0)
    }
    
    public init(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        
        self = calendar?.date(from: components) ?? Date()
    }
    
    public init(from dateString: String, dateFormat:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        self = formatter.date(from: dateString) ?? Date()
    }
    
    public var isInToday: Bool {
        return self.day == Date().day && self.month == Date().month && self.year == Date().year
    }
    
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    public func subtracted(earlierDate: Date, format: String) -> String {
        guard self > earlierDate else {
            return "Error Date"
        }
        let timeInterval = self.timeIntervalSinceReferenceDate - earlierDate.timeIntervalSinceReferenceDate
        //print("timeInterval: \(timeInterval)")
        let subtractedDate = Date(timeIntervalSince1970: timeInterval)
        //print("subtractedDate: \(subtractedDate)")
        return subtractedDate.toString(format: format)
    }
    
    public func yesterday() -> (startTime: Date, endTime: Date) {
        let endTime = self.midnight
        let startTime = endTime - 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func today() -> (startTime: Date, endTime: Date) {
        let startTime = self.midnight
        let endTime = startTime + 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func tomorrow() -> (startTime: Date, endTime: Date) {
        let startTime = self.midnight + 24 * 60 * 60
        let endTime = startTime + 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func lastWeek(from weekday: Weekday) -> (startTime: Date, endTime: Date) {
        let weekday = (calendar.component(.weekday, from: self) + 7 - weekday.rawValue) % 7
        let startTime = self.midnight - TimeInterval((weekday + 7) * 24 * 60 * 60)
        let endTime = startTime + 7 * 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func thisWeek(from weekday: Weekday) -> (startTime: Date, endTime: Date) {
        let weekday = (calendar.component(.weekday, from: self) + 7 - weekday.rawValue) % 7
        let startTime = self.midnight - TimeInterval(weekday * 24 * 60 * 60)
        let endTime = startTime + 7 * 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func nextWeek(from weekday: Weekday) -> (startTime: Date, endTime: Date) {
        let weekday = (calendar.component(.weekday, from: self) + 7 - weekday.rawValue) % 7
        let startTime = self.midnight - TimeInterval((weekday - 7) * 24 * 60 * 60)
        let endTime = startTime + 7 * 24 * 60 * 60
        return (startTime, endTime)
    }
    
    public func lastMonth()-> (startTime: Date, endTime: Date) {
        var sm = 0
        var sy = 0
        if month == 0 {
            sm = 12
            sy = year - 1
        }else{
            sm = month - 1
            sy = year
        }
        let startTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                             year: sy, month: sm, day: 1,
                             hour: 0, minute: 0, second: 0, nanosecond: 0)
        let endTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                           year: year, month: month, day: 1,
                           hour: 0, minute: 0, second: 0, nanosecond: 0)
        return (startTime, endTime)
    }
    
    public func thisMonth() -> (startTime: Date, endTime: Date) {
        let startTime = Date(calendar: calendar, timeZone: timeZone, era: era,
             year: year, month: month, day: 1,
             hour: 0, minute: 0, second: 0, nanosecond: 0)
        let endTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                           year: year, month: (month + 1) % 12, day: 1,
                           hour: 0, minute: 0, second: 0, nanosecond: 0)
        return (startTime, endTime)
    }
    
    public func thisQuarter() -> (startTime: Date, endTime: Date) {
        let startTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                             year: year, month: Int((month - 1) / 3) * 3 + 1, day: 1,
                             hour: 0, minute: 0, second: 0, nanosecond: 0)
        let endTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                           year: year, month: (Int((month - 1) / 3) + 1) * 3 + 1, day: 1,
                           hour: 0, minute: 0, second: 0, nanosecond: 0)
        return (startTime, endTime)
    }
    
    public func thisYear() -> (startTime: Date, endTime: Date) {
        let startTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                             year: year, month: 1, day: 1,
                             hour: 0, minute: 0, second: 0, nanosecond: 0)
        let endTime = Date(calendar: calendar, timeZone: timeZone, era: era,
                           year: year + 1, month: 1, day: 1,
                           hour: 0, minute: 0, second: 0, nanosecond: 0)
        return (startTime, endTime)
    }
}
