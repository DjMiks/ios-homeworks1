//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Ялынычев on 03.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var profileImage: UIImageView = {
        let stand = UIImage(named: "standup")
        let profileImage = UIImageView(image: stand)
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 60
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.green.cgColor
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()

    private lazy var profileName: UILabel = {
        
        let profileName = UILabel()
        profileName.text = "StandUP"
        profileName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        profileName.textColor = UIColor.black
        profileName.translatesAutoresizingMaskIntoConstraints = false
        return profileName
    }()
    
    private lazy var profileStatus: UILabel = {
      let profileStatus = UILabel()
        profileStatus.text = "Change your status"
        profileStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        profileStatus.textColor = UIColor.black
        profileStatus.translatesAutoresizingMaskIntoConstraints = false
        return profileStatus
    }()
    
    private lazy var statusButton: UIButton = {
        let statusButton = UIButton (type: .system)
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.setTitle("Show status", for: .normal)
        statusButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        statusButton.layer.cornerRadius = 14
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
        
    }()
    
    private lazy var uiStatus: UITextField = {
        let uiStatus = UITextField()
        uiStatus.addTarget(self, action: #selector(changeProfileStatus), for: .editingChanged)
        uiStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        uiStatus.layer.borderWidth = 1
        uiStatus.layer.borderColor = UIColor.black.cgColor
        uiStatus.backgroundColor = .white
        uiStatus.layer.cornerRadius = 12
        uiStatus.translatesAutoresizingMaskIntoConstraints = false
        return uiStatus
    }()
    
    private lazy var statusText: String = " "
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.backgroundColor = .systemGray6
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 125),
            profileImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 125),
            
            profileName.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            profileName.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            profileName.widthAnchor.constraint(equalToConstant: 110),
            profileName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 27),
            profileName.heightAnchor.constraint(equalToConstant: 18),
            
            profileStatus.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            profileStatus.widthAnchor.constraint(equalToConstant: 170),
            profileStatus.heightAnchor.constraint(equalToConstant: 20),
            profileStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -65),
            profileStatus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 40),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            uiStatus.heightAnchor.constraint(equalToConstant: 40),
            uiStatus.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150),
            uiStatus.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            uiStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -16)
               
        ])
    }
    private func setupView() {
        self.addSubview(profileImage)
        self.addSubview(profileName)
        self.addSubview(profileStatus)
        self.addSubview(statusButton)
        self.addSubview(uiStatus)
        setupConstraints()
    }
    
    @objc private func buttonPressed() {
       
        let text = statusText
        profileStatus.text = text
    }
    
    @objc func changeProfileStatus(_ uiStatus: UITextField) {
        statusText = uiStatus.text ?? "Empty Status"
    }
}
