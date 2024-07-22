//
//  File.swift
//  
//
//  Created by Filipe Ramos on 19/07/2024.
//

import UIKit

public extension UIView {
    func pin(to parentView: UIView,padding: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: padding),
            topAnchor.constraint(equalTo: parentView.topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -padding),
        ])
    }
}
