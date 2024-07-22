//
//  Array+Ext.swift
//
//
//  Created by Filipe Ramos on 14/07/2024.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
