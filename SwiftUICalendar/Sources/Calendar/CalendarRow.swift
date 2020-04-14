//
//  CalendarRow.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 12.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarRow: View {
    @Binding var date: Date

    private let dates: [Date]
    private let calendar: Calendar
    private let currentMonth: Int
    private let colors: CalendarColors

    init(
        date: Binding<Date>,
        dates: [Date],
        calendar: Calendar,
        currentMonth: Int,
        colors: CalendarColors
    ) {
        self._date = date
        self.dates = dates
        self.calendar = calendar
        self.currentMonth = currentMonth
        self.colors = colors
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(dates, id: \.self) {
                CalendarButton(
                    calendar: self.calendar,
                    date: $0,
                    text: String(describing: self.calendar.component(.day, from: $0)),
                    color: self.color(from: $0),
                    action: self.select
                )
            }
        }
    }

    private func color(from date: Date) -> CalendarColors.Button {
        if calendar.isDate(date, inSameDayAs: self.date) {
            return colors.selected
        } else if calendar.component(.month, from: date) == currentMonth {
            return colors.current
        } else {
            return colors.other
        }
    }

    private func select(date: Date) {
        self.date = date
    }
}
