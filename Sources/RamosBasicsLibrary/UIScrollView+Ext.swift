//
//  UIScrollView+Ext.swift
//
//
//  Created by Filipe Ramos on 14/07/2024.
//

import UIKit

public extension UIScrollView {
    var isAtBottom: Bool {
        let offset = contentOffset.y
        let contentHeight = contentSize.height
        let height = frame.size.height
        
        return offset >= contentHeight - height
    }
    
    func pinToView(_ view: UIView, contentView: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        let contentHeightConstraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        contentHeightConstraint.priority = .defaultLow
        contentHeightConstraint.isActive = true
    }
}
