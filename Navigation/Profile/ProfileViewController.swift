//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private  lazy var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
    }
    
    @objc private func typing() {        
        view.endEditing(true)
    }
    

}
