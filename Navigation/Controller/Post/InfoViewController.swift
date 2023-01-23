//
//  InfoViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Show", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.sizeToFit()
        button.center = view.center
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink

        view.addSubview(button)
        button.sizeToFit()
        button.center = view.center
    }
// Вывод информации Alertcontroll
    @objc private func tap() {
        let sx = UIAlertController(title: "Hello", message: "New note?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .default) {
            UIAlertAction in
            NSLog("Needs to be improved")
        }
        
        let okAction = UIAlertAction(title: "Yes", style: .default) {
            UIAlertAction in
            NSLog("All reght")
        }
        
            
        sx.addAction(okAction)
        sx.addAction(cancelAction)
        present(sx, animated: true)
   
    }
    
}
