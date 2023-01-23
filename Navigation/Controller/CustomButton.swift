//
//  CustomButton.swift
//  Navigation
//
//  Created by Максим Ялынычев on 22.01.2023.
//

import UIKit

class CustomButton: UIButton {
    
    private let buttonAction: () -> ()
    
    init (action: @escaping () -> (),
         title: String,
         titleColor: UIColor,
         color: UIColor
    ) {
        self.buttonAction = action
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        sizeToFit()
        self.center = center
        layer.cornerRadius = 15
    }
    @objc func buttonTapped() {
        buttonAction()
    }
    
}
