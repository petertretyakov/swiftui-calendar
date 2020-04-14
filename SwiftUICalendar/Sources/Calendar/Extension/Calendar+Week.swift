//
//  Calendar+Week.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 15.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import Foundation

extension Calendar {
    func startOfWeek(for date: Date) -> Date {
        let weekday = component(.weekday, from: date)
        if weekday == firstWeekday {
            return startOfDay(for: date)
        } else if weekday < firstWeekday {
            let difference = -7 + (firstWeekday - weekday)
            guard let first = self.date(byAdding: .day, value: difference, to: date, wrappingComponents: false)
            else { fatalError("Failed to subtract \(difference) days from \(date)") }

            return startOfDay(for: first)
        } else {
            let difference = firstWeekday - weekday
            guard let first = self.date(byAdding: .day, value: difference, to: date, wrappingComponents: false)
            else { fatalError("Failed to subtract \(difference) days from \(date)") }

            return startOfDay(for: first)
        }
    }

    func endOfWeek(for date: Date) -> Date {
        let start = startOfWeek(for: date)
        guard let end = self.date(byAdding: .day, value: 6, to: start, wrappingComponents: false)
        else { fatalError("Failed to add 6 days to \(date)") }

        return end
    }
}
