//
//  PostViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = "Unknown"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
        self.navigationItem.title = titlePost
        
        lazy var infoButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(showInfo))

        self.navigationItem.rightBarButtonItem = infoButton
    }
    

    @objc func showInfo() {
        let sx = InfoViewController()
        present(sx, animated: true)
    }

}
