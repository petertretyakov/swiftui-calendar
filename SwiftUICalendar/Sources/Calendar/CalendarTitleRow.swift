//
//  CalendarTitleRow.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 12.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarTitleRow: View {
    @Binding var month: Int
    @Binding var year: Int

    struct Actions {
        let previous: () -> Void
        let current: () -> Void
        let next: () -> Void
    }

    private let calendar: Calendar
    private let colors: CalendarColors
    private let actions: Actions

    init(month: Binding<Int>, year: Binding<Int>, calendar: Calendar, colors: CalendarColors, actions: Actions) {
        self._month = month
        self._year = year
        self.calendar = calendar
        self.colors = colors
        self.actions = actions
    }

    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            Button(action: actions.previous) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(colors.chevron)
            }
            Button(action: actions.current) {
                Text("\(self.calendar.standaloneMonthSymbols[self.month - 1]) \(String(describing: self.year))")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(colors.currentMonth)
            }
            Button(action: actions.next) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(colors.chevron)
            }
            Spacer()
        }
    }
}
