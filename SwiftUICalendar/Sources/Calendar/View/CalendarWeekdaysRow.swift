//
//  CalendarWeekdaysRow.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 11.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarWeekdaysRow: View {
    @Binding var date: Date

    private let calendar: Calendar
    private let weekdays: [(text: String, date: Date)]
    private let color: CalendarColors.Button

    init(date: Binding<Date>, calendar: Calendar, color: CalendarColors.Button) {
        self._date = date

        self.calendar = calendar
        let calendarWeekdays = calendar.veryShortStandaloneWeekdaySymbols
        var weekdays: [String] = []
        for index in calendar.firstWeekday ... calendarWeekdays.count {
            weekdays.append(calendarWeekdays[index - 1])
        }
        if calendar.firstWeekday > 1 {
            for index in 1 ..< calendar.firstWeekday {
                weekdays.append(calendarWeekdays[index - 1])
            }
        }

        let first = calendar.startOfWeek(for: date.wrappedValue)
        let dates: [Date] = weekdays.enumerated().compactMap {
            calendar.date(byAdding: .day, value: $0.offset, to: first, wrappingComponents: false)
        }
        guard weekdays.count == dates.count else {
            fatalError("Number of weekdays \(weekdays) doesn't match number of dates \(dates)")
        }

        self.weekdays = (0 ..< weekdays.count).map { (text: weekdays[$0], date: dates[$0]) }
        self.color = color
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(weekdays.indices) {
                CalendarButton(
                    calendar: self.calendar,
                    date: self.weekdays[$0].date,
                    text: self.weekdays[$0].text,
                    color: self.color,
                    action: self.select
                )
            }
        }
    }

    private func select(date: Date) {
        self.date = date
    }
}
