//
//  CalendarColors.swift
//  SwiftUICalendar
//
//  Created by Peter Tretyakov on 12.04.2020.
//  Copyright © 2020 Peter Tretyakov. All rights reserved.
//

import SwiftUI

struct CalendarColors {
    let chevron: Color
    let currentMonth: Color
    let weekday: Button
    let current: Button
    let other: Button
    let selected: Button

    struct Button {
        let circle: Color
        let text: Color
    }
}
