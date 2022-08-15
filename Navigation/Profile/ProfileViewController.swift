//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private  lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        setup()
        setupSubview()
        setupConstraints()
        
        let keyboard = UITapGestureRecognizer(target: self, action: #selector(self.typing))
        view.addGestureRecognizer(keyboard)
        
    }
        
    @objc private func typing() {        
        view.endEditing(true)
    }
    
    private func setup() {
        view.backgroundColor = .lightGray
}
    
    private func setupSubview() {
        view.addSubview(profileHeaderView)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            
            profileHeaderView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
}
