//
//  AuthorizeUIButton.swift
//  LoginForm
//
//  Created by Mikita Piatrushka on 2.11.22.
//

import UIKit

final class AuthorizeUIButton: ActionButtonClass{
    
    override func setup() {
        super.setup()
    }
    
    override var isHighlighted: Bool{
        didSet {
            UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve]) {[self] in
                if isHighlighted{
                    backgroundColor = CustomColors.littleBoyBlueColor.withAlphaComponent(0.5)
                }else{
                    backgroundColor = UIColor.white
                }
            }
        }
    }
}
