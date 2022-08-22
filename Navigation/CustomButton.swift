//
//  CustomButton.swift
//  Navigation
//
//  Created by Максим Ялынычев on 14.08.2022.
//

import UIKit

class CustomButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.8 : 1.0
        }
    }
    override open var isSelected: Bool {
        didSet {
            alpha = isSelected ? 0.8 : 1.0
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.8
        }
    }
}
