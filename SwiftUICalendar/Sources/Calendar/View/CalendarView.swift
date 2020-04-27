//
//  CalendarView.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 11.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    @State var month: Int
    @State var year: Int

    private let calendar: Calendar
    private let colors: CalendarColors

    private enum Constant {
        static let buttonSide: CGFloat = 32
    }

    init(date: Binding<Date>, calendar: Calendar, colors: CalendarColors) {
        self._date = date
        self._month = State(initialValue: calendar.component(.month, from: date.wrappedValue))
        self._year = State(initialValue: calendar.component(.year, from: date.wrappedValue))

        self.calendar = calendar
        self.colors = colors
    }

    var body: some View {
        VStack(spacing: 8) {
            CalendarTitleRow(
                month: self.$month,
                year: self.$year,
                calendar: self.calendar,
                colors: self.colors,
                actions: .init(previous: self.previousMonth, current: self.currentMonth, next: self.nextMonth)
            )
            VStack(spacing: 0) {
                CalendarWeekdaysRow(
                    date: $date,
                    calendar: self.calendar,
                    color: self.colors.weekday
                )
                ForEach(self.dates, id: \.self) {
                    CalendarRow(
                        date: self.$date,
                        dates: $0,
                        calendar: self.calendar,
                        currentMonth: self.month,
                        colors: self.colors
                    )
                }
            }
        }
    }

    private func previousMonth() {
        guard
            let current = calendar.date(from: DateComponents(year: year, month: month, day: 1)),
            let previous = calendar.date(byAdding: .month, value: -1, to: current, wrappingComponents: false)
        else { return }

        month = calendar.component(.month, from: previous)
        year = calendar.component(.year, from: previous)
    }

    private func currentMonth() {
        month = calendar.component(.month, from: Date())
        year = calendar.component(.year, from: Date())
    }

    private func nextMonth() {
        guard
            let current = calendar.date(from: DateComponents(year: year, month: month, day: 1)),
            let next = calendar.date(byAdding: .month, value: 1, to: current, wrappingComponents: false)
        else { return }

        month = calendar.component(.month, from: next)
        year = calendar.component(.year, from: next)
    }

    var dates: [[Date]] {
        guard let firstDay = calendar.date(from: DateComponents(year: year, month: month, day: 1)) else { return [] }

        let begin = calendar.startOfWeek(for: firstDay)

        var dates: [Date] = []
        for day in (0 ..< (6 * 7)) {
            guard let date = calendar.date(byAdding: .day, value: day, to: begin, wrappingComponents: false) else { return [] }

            dates.append(date)
        }

        return stride(from: 0, to: dates.count, by: 7).map {
            Array(dates[$0 ..< min($0 + 7, dates.count)])
        }
    }
}
