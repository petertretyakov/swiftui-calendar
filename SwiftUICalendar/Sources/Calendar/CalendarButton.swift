//
//  CalendarButton.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 11.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarButton: View {
    private let calendar: Calendar
    private let date: Date
    private let action: (Date) -> Void
    private let color: CalendarColors.Button
    private let text: String

    init(
        calendar: Calendar,
        date: Date,
        text: String,
        color: CalendarColors.Button,
        action: @escaping (Date) -> Void
    ) {
        self.calendar = calendar
        self.date = calendar.startOfDay(for: date)
        self.text = text
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: select) {
            HStack {
                Spacer(minLength: 4)
                ZStack {
                    Circle()
                        .frame(minWidth: 24, maxWidth: 32, minHeight: 24, maxHeight: 32)
                    Text(self.text)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(color.text)
                }
                Spacer(minLength: 4)
            }
        }
            .frame(height: 40)
            .foregroundColor(color.circle)
    }

    private func select() {
        action(date)
    }
}
