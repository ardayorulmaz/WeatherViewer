//
//  XibInstantiable.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 12.10.2021.
//

import Foundation
import UIKit
// Exrtension for instantiable xibs for easy to use reusable views.
protocol XibInstantiatable {
    func instantiate()
}

extension XibInstantiatable where Self: UIView {
    func instantiate() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[view]|",
            options:NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[view]|",
            options:NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
    }
}

