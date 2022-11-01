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
        layer.borderWidth = 5.0
        layer.borderColor = CustomColors.littleBoyBlueColor.cgColor
        
    }
}
