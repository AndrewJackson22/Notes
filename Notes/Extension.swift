//
//  Extension.swift
//  Notes
//
//  Created by Андрей Михайлов on 04.03.2022.
//

import UIKit


extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubViews(_ subviews: UIView...) {
        subviews.forEach{ addSubview($0) }
    }
}
