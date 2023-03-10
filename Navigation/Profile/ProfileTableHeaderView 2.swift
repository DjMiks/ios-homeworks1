//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.08.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubview()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(gesture)
    }
    
    private func setupSubview() {
        self.addSubview(self.profileHeaderView)
    }
    
    // MARK: - Private
    
    func setup (fullName: String, statusText: String, avatar: UIImage) {
        profileHeaderView.profileName.text = fullName
        profileHeaderView.profileStatus.text = statusText
        profileHeaderView.profileImage.image = avatar
    }
    
    private func setupConstraints() {
        let safeAreeGuide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreeGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreeGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreeGuide.rightAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreeGuide.bottomAnchor)
        
        ])
    }
    @objc private func tap() {
        self.endEditing(true)
    }
}
