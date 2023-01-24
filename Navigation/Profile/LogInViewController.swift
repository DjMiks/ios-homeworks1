//
//  LogInViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 13.08.2022.
//

import UIKit



class LogInViewController: UIViewController {
    
    // MARK: delegete
    
    var loginDelegate: LoginViewControllerDelegate?
    
    let koordinator: LoginKoordinator
    
    init(koordinator: LoginKoordinator) {
        self.koordinator = koordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: subview
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
        
    }()
    
    private lazy var logoImageVK: UIImageView = {
        let image = UIImage(named: "logo_vk")
        let logoImageVK = UIImageView(image: image)
        logoImageVK.translatesAutoresizingMaskIntoConstraints = false
        return logoImageVK
    }()
    
    private lazy var loginTextField: UITextField = { [unowned self]
        in let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Email or Phone"
        loginTextField.leftView = UIView(frame: CGRect(x:0, y:0, width:15, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.textColor = .black
        loginTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginTextField.tintColor = UIColor(named: "AccentColor")
        loginTextField.autocapitalizationType = .none
        loginTextField.backgroundColor = .systemGray6
        
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.layer.borderWidth = 0.5
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.autocorrectionType = .no
        loginTextField.keyboardType = .namePhonePad
        loginTextField.delegate = self
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = { [unowned self] in let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.leftView = UIView(frame: CGRect(x:0, y:0, width:15, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.tintColor = UIColor(named: "AceentColor")
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .systemGray6
        
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        return passwordTextField
    }()
    
    private lazy var stackView: UIStackView = {
        let strackView = UIStackView ()
        strackView.translatesAutoresizingMaskIntoConstraints = false
        strackView.layer.cornerRadius = 10
        strackView.layer.borderColor = UIColor.lightGray.cgColor
        strackView.layer.borderWidth = 0.5
        strackView.clipsToBounds = true
        
        strackView.axis = .vertical
        strackView.distribution = .fillEqually
        strackView.alignment = .fill
        strackView.spacing = -0.5
        
        strackView.addArrangedSubview(loginTextField)
        strackView.addArrangedSubview(passwordTextField)
        return strackView
    }()
    
    private lazy var logInButton: CustButton = {
        let logInButton = CustButton(type: .system)
        logInButton.layer.cornerRadius = 10
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = UIColor(named: "ColorLog")
        
        logInButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        return logInButton
    }()
    
    //MARK: Сycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        
        removeKeyboardObservers()
    }
    
    //MARK: Objc methods
    
    @objc func willShowKeyBoard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    
    @objc private func tap() {
        
#if DEBUG
        let user = TestUserService().testUser
#else

        let user = CurrentUserService().currentUser
#endif
        
        guard let accessed = loginDelegate?.check(inputedLogin: loginTextField.text!, inputedPass: passwordTextField.text!) else { return }
        
        if accessed {
            let proflaVC = ProfileViewController()
            proflaVC.currenUser = user
            self.navigationController?.pushViewController(proflaVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Authentication Error", message: "Wrong login or password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }


//        if let loginUser = log {
//            if pass == passwordTextField.text! {
//                let proflaVC = ProfileViewController()
//                proflaVC.currenUser = loginUser
//                self.navigationController?.pushViewController(proflaVC, animated: true)
//            } else {
//                print ("The invalid password error.")
//            }
//        } else {
//            print("The invalid login error.")
//        }
//    }


        
//MARK: Private metod
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(logoImageVK)
        scrollView.addSubview(logInButton)
        
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageVK.heightAnchor.constraint(equalToConstant: 100),
            logoImageVK.widthAnchor.constraint(equalToConstant: 100),
            logoImageVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageVK.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(self.willShowKeyBoard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
}

// MARK: - EXTENSIONS
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
    protocol LoginViewControllerDelegate {
        func check (inputedLogin: String, inputedPass: String) -> Bool
    }
    
    struct LoginInspector: LoginViewControllerDelegate {
        func check(inputedLogin: String, inputedPass: String) -> Bool {
            return Checker.service.check(inputedLogin: inputedLogin, inputedPass: inputedPass)
        }
        
    }

