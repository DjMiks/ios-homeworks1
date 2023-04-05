//
//  LogInViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 13.08.2022.
//

import UIKit
import AVFoundation
import FirebaseAuth
import RealmSwift

class LogInViewController: UIViewController {
    
    // MARK: delegete
    
    var realmService = RealmService()
    
    var loginDelegate: LoginViewControllerDelegate?
    
    
    //MARK: media
    
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    
    private var currentFile: AVAudioFile!
    
    private let URLarray: [URL?] = [
        Bundle.main.url(forResource: "Captain", withExtension: ".mp3"),
        Bundle.main.url(forResource: "Malboro", withExtension: ".mp3"),
        Bundle.main.url(forResource: "Minor", withExtension: ".mp3"),
        Bundle.main.url(forResource: "Polovina_moya", withExtension: ".mp3"),
        Bundle.main.url(forResource: "Samurajj", withExtension: ".mp3")]
    
    private let songNamesArray: [String] = ["Malboro","Captain","Minor","Polovina_moya","Samurajj"]
    
    private var currentIndex = 0
    
    private func setupAudio() {
        guard let fileURL = URLarray[0]
        else { return }
        do {
            
            let file = try AVAudioFile(forReading: fileURL)
            let format = file.processingFormat
            
            currentFile = file
            
            configureEngine(with: format)
        } catch {
            print("Error reading the audio file: \(error.localizedDescription)")
        }
    }
    
    private func configureEngine(with format: AVAudioFormat) {
        engine.attach(player)
        
        engine.connect(
            player,
            to: engine.mainMixerNode,
            format: format)
        
        engine.prepare()
        
        do {
            try engine.start()
            
            guard
                let file = currentFile
            else {  return  }
            
            player.scheduleFile(file, at: nil) {
            }
        } catch {
            print("Error starting the player: \(error.localizedDescription)")
        }
    }
    
    
    
    // MARK: subview
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "playpause.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()
    
    private lazy var currenSongLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = contentView.backgroundColor
        label.translatesAutoresizingMaskIntoConstraints = false
    //    label.textColor = .systemTeal
        label.textColor = .createColor(lightMode: .systemBlue, darkMode: .systemTeal)
        label.text = ""
        return label
    }()
         
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        return button
    }()
    
    private lazy var playBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPlayBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var playForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPlayForward), for: .touchUpInside)
        return button
    }()
    
    private lazy var playerStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(playBackButton)
        stackView.addArrangedSubview(playPauseButton)
        stackView.addArrangedSubview(playForwardButton)
        stackView.addArrangedSubview(stopButton)
        
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .createColor(lightMode: .white, darkMode: .systemGray)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .createColor(lightMode: .white, darkMode: .systemGray)
        return contentView
        
    }()
    
    private lazy var contentView2: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .createColor(lightMode: .white, darkMode: .systemGray)
        
        return contentView
    }()
    
    private lazy var logoImageVK: UIImageView = {
        let image = UIImage(named: "logo_vk")
        let logoImageVK = UIImageView(image: image)
        logoImageVK.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeLogoTimer))
        logoImageVK.addGestureRecognizer(gesture)
        logoImageVK.isUserInteractionEnabled = true
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
        loginTextField.keyboardType = .emailAddress
        loginTextField.delegate = self
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = { [unowned self] in
        let passwordTextField = UITextField()
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
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.layer.cornerRadius = 10
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitle("Log In", for: .normal)
    //  logInButton.backgroundColor = UIColor(named: "ColorLog")
        logInButton.backgroundColor = .createColor(lightMode: UIColor(named: "ColorLog") ?? .red, darkMode: .systemGray)
        
        
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        logInButton.isUserInteractionEnabled = true
        
        
        return logInButton
    }()
    
    private lazy var newUserButton: UIButton = {
       let buttoon = UIButton()
        buttoon.translatesAutoresizingMaskIntoConstraints = false
        buttoon.setTitle("New User", for: .normal)
        buttoon.layer.cornerRadius = 10
        buttoon.backgroundColor = .systemMint
        buttoon.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
        return buttoon
    }()
    
    //MARK: Сycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        contentView.addSubview(playerStackView)
        contentView.addSubview(currenSongLabel)
        
        setupSubview()
        NSLayoutConstraint.activate([
            currenSongLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currenSongLabel.topAnchor.constraint(equalTo:logoImageVK.bottomAnchor, constant: 20),
            
            playerStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            playerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            playerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ])
        setupConstraints()
        setupAudio()
        
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
    
    
    // MARK: - Actions
    
    @objc func play() {
        if player.isPlaying {
            player.pause()
            DispatchQueue.main.async {
                self.currenSongLabel.text = ""
            }
        } else {
            player.play()
            DispatchQueue.main.async {
                self.currenSongLabel.text = "You are song - \(self.songNamesArray[self.currentIndex])"
            }
        }
    }
    
    @objc func stop() {
        player.stop()
        DispatchQueue.main.async {
            self.currenSongLabel.text = ""
        }
        player.scheduleFile(currentFile!, at: nil)
    }
    
    @objc func tapPlayBack() {
        player.stop()
        
        if currentIndex != 0 {
            currentIndex = currentIndex - 1
            
            guard let fileURL = URLarray[currentIndex] else {
                return
            }
            
            do {
                let file = try AVAudioFile(forReading: fileURL)
                let format = file.processingFormat
                
                currentFile = file
                
                DispatchQueue.main.async {
                    self.currenSongLabel.text = "You are song - \(self.songNamesArray[self.currentIndex])"
                }
                
                configureEngine(with: format)
            } catch {
                print("Error reading the audio file: \(error.localizedDescription)")
            }
            player.play()
        }
    }
    
    @objc func tapPlayForward() {
        
        player.stop()
        
        if currentIndex + 1 < URLarray.count {
            currentIndex = currentIndex + 1
            
            guard let fileURL = URLarray[currentIndex] else {
                return
            }
            
            do {
                let file = try AVAudioFile(forReading: fileURL)
                let format = file.processingFormat
                
                currentFile = file
                
                DispatchQueue.main.async {
                    self.currenSongLabel.text = "You are song - \(self.songNamesArray[self.currentIndex])"
                }
                
                configureEngine(with: format)
                
            } catch {
                print("Error reading the audio file: \(error.localizedDescription)")
            }
            
            player.play()
            
        }
    }
    
    //MARK: Objc methods
    
    @objc func willShowKeyBoard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    
    //MARK: Private metod
    
    @objc private func changeLogoTimer() {
        print ("Vk_logo")
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(logoImageVK)
        scrollView.addSubview(logInButton)
        scrollView.addSubview(newUserButton)
        
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
            
            logoImageVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 130),
            logoImageVK.heightAnchor.constraint(equalToConstant: 100),
            logoImageVK.widthAnchor.constraint(equalToConstant: 100),
            logoImageVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageVK.bottomAnchor, constant: 130),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            newUserButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            newUserButton.heightAnchor.constraint(equalToConstant: 50),
            newUserButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newUserButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self, selector: #selector(self.willShowKeyBoard(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
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
    
    
    
    @objc private func createNewUser() {
        
        var login: String?
        var pass: String?
        
        if loginTextField.text == "" {
            let ac = UIAlertController(title: "Ops", message: "One of fields is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            self.navigationController?.present(ac, animated: true)
        }else {
            login = loginTextField.text!
        }
        
        if passwordTextField.text == ""{
            let ac = UIAlertController(title: "Ops", message: "Fields is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            self.navigationController?.present(ac, animated: true)
        } else {
            pass = passwordTextField.text!
        }
        
        if login != nil && pass != nil {
            let usersArray:[UserModel] = Array(realmService.realm.objects(UserModel.self))
            var currentUser:UserModel?
            for user in usersArray {
                if user.name == loginTextField.text {
                    currentUser = user
                }
            }
            if currentUser == nil {
                self .realmService.createUser(name: login!, password: pass!)
                let ac = UIAlertController(title: "Success", message: "User was created", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel)
                ac.addAction(action)
                self.navigationController?.present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Ops", message: "login exists, create a new one", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel)
                ac.addAction(action)
                self.navigationController?.present(ac, animated: true)
            }
        }
    }
    
    @objc private func logIn() {

        let usersArray:[UserModel] = Array(realmService.realm.objects(UserModel.self))
        
        var currentUser: UserModel?
        
        for user in usersArray {
            if user.name == loginTextField.text && user.password == passwordTextField.text {
                currentUser = user
            }
        }
        if currentUser != nil {
            let profileVC = ProfileViewController()
            let loginnedUser = User(login: currentUser?.name ?? "masha", fullName: "You Name", avatar: UIImage(named: "masha")!, status: "Welcom to Profile")
            profileVC.currenUser = loginnedUser
            UserDefaults().set(true, forKey: "IsLogined")
            self.navigationController?.pushViewController(profileVC, animated: true)

        } else {
            let ac = UIAlertController(title: "Error", message: "Invalid login or password, please try again", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(alertAction)
            self.navigationController?.present(ac, animated: true)
        }
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
        
        func chechCredentials(inputedLogin: String, inputedPass: String, completion: ((_ status: LoginResult)->Void)?)
        func signUp(inputedLogin: String, inputedPass: String, completion: ((_ isCreated: Bool) -> Void)?)
    }

    struct LoginInspector: LoginViewControllerDelegate {
        
        func signUp(inputedLogin: String, inputedPass: String, completion: ((_ isCreated: Bool) -> Void)?) {
            return CheckerService().signUp(inputedLogin: inputedLogin, inputedPass: inputedPass, completion: completion)
        }
        
        func chechCredentials(inputedLogin: String, inputedPass: String, completion: ((_ status: LoginResult) -> Void)?) {
            return CheckerService().chechCredentials(inputedLogin: inputedLogin, inputedPass: inputedPass, completion: completion)
        }
    }

