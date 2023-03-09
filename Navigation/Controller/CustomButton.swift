//
//  CustomButton.swift
//  Navigation
//
//  Created by Максим Ялынычев on 22.01.2023.
//

import UIKit

class CustomButton: UIButton {
    
    private let buttonCloused: (() -> ())
    
    init (
         title: String,
         titleColor: UIColor,
         color: UIColor,
         clous: @escaping (() -> ())
    ) {
        self.buttonCloused = clous
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        self.center = center
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        sizeToFit()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped() {
        buttonCloused()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
}
