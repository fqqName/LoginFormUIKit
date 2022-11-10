//
//  RoundButtonsClass.swift
//  LoginForm
//
//  Created by Mikita Piatrushka on 2.11.22.
//

import UIKit

final class RoundedButton: ActionButton {
    
    override func setup() {
        super.setup()
        setTitleColor(CustomColors.littleBoyBlueColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24)
        titleLabel?.textColor = CustomColors.littleBoyBlueColor
        layer.masksToBounds = true
        layer.borderColor = CustomColors.littleBoyBlueColor.cgColor
        layer.borderWidth = 1.5
        clipsToBounds = true
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        layer.cornerRadius = frame.height / 2
    }
}
