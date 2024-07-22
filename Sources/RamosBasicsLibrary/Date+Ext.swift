//
//  File.swift
//  
//
//  Created by Filipe Ramos on 19/07/2024.
//

import Foundation

public extension Date {
    func convertToShortMonthYearFormat() -> String {
        formatted(.dateTime.month().year())
    }
}
