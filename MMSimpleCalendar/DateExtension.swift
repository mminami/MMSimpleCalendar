//
//  DateExtension.swift
//  MMSimpleCalendar
//
//  Created by mminami on 2017/10/01.
//

import Foundation

extension Date {
    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }

    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }

    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    var firstDateInMonth: Date {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: comps)!
    }

    var lastDateInMonth: Date {
        let calendar = Calendar.current
        let components = DateComponents(month: 1, day: -1)
        return calendar.date(byAdding: components, to: self.firstDateInMonth)!
    }

    var lastMonth: Date {
        let calendar = Calendar.current
        let components = DateComponents(month: -1)
        return calendar.date(byAdding: components, to: self)!
    }

    var nextMonth: Date {
        let calendar = Calendar.current
        let components = DateComponents(month: 1)
        return calendar.date(byAdding: components, to: self)!
    }

    func fullDatesInMonth() -> [Date] {
        let calendar = Calendar.current

        var dates = [Date] ()

        var components = Calendar.current.dateComponents([.year, .month], from: self)

        for weekOfMonth in 1...self.weekRangeInMonth().count {
            components.weekOfMonth = weekOfMonth
            for weekday in 1...7 {
                components.weekday = weekday
                if let date = calendar.date(from: components) {
                    dates.append(date)
                }
            }
        }

        return dates
    }

    func dayRangeInMonth() -> Range<Int> {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)!
    }

    func weekRangeInMonth() -> Range<Int> {
        let calendar = Calendar.current
        return calendar.range(of: .weekOfYear, in: .month, for: self)!
    }

    func dateString(with format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
