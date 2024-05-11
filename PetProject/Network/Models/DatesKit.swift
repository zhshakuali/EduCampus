//
//  DatesKit.swift
//  PetProject
//
//  Created by Жансая Шакуали on 02.05.2024.
//

import Foundation

final class DatesKit {
    
    enum DateFormat: String {
        case weekdayMonthDayYear = "EEEE, MMM d, yyyy, h:mm a"
        case dayMonthYear = "MM/dd/yyyy"
        case dayMonthYearHoursMinutes = "MM-dd-yyyy HH:mm"
        case monthDayHoursMinutes = "MMM d, h:mm a"
        case fullMonthYear = "MMMM yyyy"
        case monthYear = "MMM d, yyyy"
        case shortWeekdayMonthYearHoursMinutes = "E, d MMM yyyy HH:mm:ss"
        case hoursMinutes = "HH:mm"
    }
    
    private static var formatter = DateFormatter()
    
    static func format(_ string: String, with format: DateFormat) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: string) else {
            return nil
        }
        
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    static func weekday(from day: Int) -> String {
        guard day <= 7 else {
            return ""
        }
        
        formatter.locale = .init(identifier: "en_US_POSIX")
        return formatter.weekdaySymbols[day]
    }
}
