//
//  Date+Extensions.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func subtracted(earlierDate: Date, format: String) -> String {
        guard self > earlierDate else {
            return "Error Date"
        }
        let timeInterval = self.timeIntervalSinceReferenceDate - earlierDate.timeIntervalSinceReferenceDate
        print("timeInterval: \(timeInterval)")
        let subtractedDate = Date(timeIntervalSince1970: timeInterval)
        print("subtractedDate: \(subtractedDate)")
        return subtractedDate.toString(format: format)
    }
}
