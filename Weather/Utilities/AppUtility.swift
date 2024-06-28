//
//  AppUtility.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import Foundation

class AppUtility {
    static func intervalToFullDate(interval: Int, shift: Int) -> String {
        var date = Date(timeIntervalSince1970: TimeInterval(interval))
        date = date.addingTimeInterval(TimeInterval(shift))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy  h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let formattedDate = dateFormatter.string(from: date)

        return formattedDate
    }
    
    static func intervalToTime(interval: Int?, shift: Int) -> String {
        guard let interval else {
            return "--"
        }
        var date = Date(timeIntervalSince1970: TimeInterval(interval))
        date = date.addingTimeInterval(TimeInterval(shift))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let formattedDate = dateFormatter.string(from: date)

        return formattedDate
    }
}
