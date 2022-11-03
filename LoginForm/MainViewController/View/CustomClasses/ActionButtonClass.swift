//
//  ActionButtonClass.swift
//  LoginForm
//
//  Created by Mikita Piatrushka on 1.11.22.
//

import UIKit

class ActionButtonClass: UIButton{
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = .white
        layer.borderWidth = 2.0
        layer.borderColor = CustomColors.littleBoyBlueColor.cgColor
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
