//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Ялынычев on 03.08.2022.
//

import UIKit
import SnapKit

#if DEBUG
let userService = TestUserService()
#else
let userService = CurrentUserService()
#endif

let logUser = userService.user

class ProfileHeaderView: UIView {

    private lazy var profileImage: UIImageView = {
        let stand = logUser.avatar
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
        profileName.text = logUser.fullName
        profileName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        profileName.textColor = UIColor.black
        profileName.translatesAutoresizingMaskIntoConstraints = false
         return profileName
    }()
    
    private lazy var profileStatus: UILabel = {
      let profileStatus = UILabel()
        profileStatus.text = logUser.status
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
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self .setupView()
        self.backgroundColor = .systemGray6
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Private Methods
            
        private func setupView() {
            self.addSubview(profileImage)
            self.addSubview(profileName)
            self.addSubview(profileStatus)
            self.addSubview(statusButton)
            self.addSubview(uiStatus)
         //   setupConstraints()
        
            
    //MARK: Snapkit constraints
    
     profileImage.snp.makeConstraints { (make) -> Void in
        make.leading.equalTo(self).offset(16)
        make.top.equalTo(self).offset(16)
        make.width.equalTo(125)
        make.height.equalTo(125)
    }
    
    profileName.snp.makeConstraints{ (make) -> Void in
        make.leading.equalTo(self).offset(150)
        make.trailing.equalTo(self).offset(16)
        make.top.equalTo(self).offset(27)
        make.height.equalTo(18)
     }
    
    profileStatus.snp.makeConstraints { (make) -> Void in
        make.leading.equalTo(self).offset(150)
        make.trailing.equalTo(self).offset(16)
        make.height.equalTo(20)
        make.bottom.equalTo(statusButton.snp_topMargin).offset(-65)
            
     }
    
    statusButton.snp.makeConstraints { (make) -> Void in
        make.leading.equalTo(self).offset(16)
        make.trailing.equalTo(self).offset(-16)
        make.top.equalTo(self).offset(185)
        make.height.equalTo(50)
        make.bottom.equalTo(self).offset(-15)
     }
    
    uiStatus.snp.makeConstraints { (make) -> Void in
        make.leading.equalTo(self).offset(150)
        make.trailing.equalTo(self).offset(-16)
        make.height.equalTo(40)
        make.bottom.equalTo(statusButton.snp_topMargin).offset(-16)
      }
   }
    
//MARK: Action
    
    @objc private func buttonPressed() {
        let text = statusText
        profileStatus.text = text
    }
    
    @objc  func changeProfileStatus(_ uiStatus: UITextField) {
        statusText = uiStatus.text ?? "Empty Status"
    }
}
