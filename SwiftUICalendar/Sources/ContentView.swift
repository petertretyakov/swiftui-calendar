//
//  ContentView.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 15.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var date: Date = Date()

    private let formatter: DateFormatter = DateFormatter()
    private let calendar: Calendar = .current
    private let colors = CalendarColors(
        chevron: .black,
        currentMonth: .black,
        weekday: .init(circle: .blue, text: .white),
        current: .init(circle: .primary, text: .white),
        other: .init(circle: .secondary, text: .white),
        selected: .init(circle: .red, text: .white)
    )

    init() {
        formatter.dateStyle = .full
        formatter.timeStyle = .none
    }

    var body: some View {
        print(date)
        print(formatter.string(from: date))
        return VStack {
            CalendarView(date: $date, calendar: calendar, colors: colors)
            Text(formatter.string(from: date))
        }
    }
}
