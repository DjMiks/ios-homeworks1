//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    var output: FeedOutput?
    
    private enum CustomError: Error {
        case emptyTextField
        case wrongPassword
    }
    
     
    private lazy var checkTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = " Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.layer.backgroundColor = UIColor.orange.cgColor
        field.layer.borderWidth = 0.5
        field.layer.cornerRadius = 12
        field.backgroundColor = .lightText
        field.leftViewMode = .always
         return field
    }()
    
    private lazy var checkGuessButton = CustomButton(title: "Check Pass", titleColor: .black, color: .systemBlue) {
        self.checkPass()
    }
    
    private lazy var button1 = CustomButton(title: "ShowPost", titleColor: .white, color: .orange) {
        self.showPost()
    }
    
    private lazy var button2 = CustomButton(title: "Show post again",  titleColor: .black, color: .cyan) {
        self.showPost()
    }

    
    
    private lazy var  checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 15
        label.backgroundColor =  .lightText
        label.textAlignment = .center
        label.clipsToBounds = true
         return label
    }()
    
  //  Кнопка для перехода в посты
private lazy var button: UIButton = {
        let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .lightText
        button.layer.cornerRadius = 15
        button.setTitle("Show my Post", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
         return button
}()
    
    var post = Post(title: "You Post")
   
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = .systemGreen
       tabBarController?.tabBar.backgroundColor = .white
       view.addSubview(checkTextField)
       view.addSubview(checkGuessButton)
       view.addSubview(checkLabel)
       checkGuessButton.layer.cornerRadius = 15
       checkGuessButton.layer.borderWidth = 1
       checkGuessButton.layer.borderColor = UIColor.black.cgColor
       setupConstraint()
       setupButton()
      
   }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            checkTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            checkTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            checkTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            checkTextField.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.topAnchor.constraint(equalTo: checkTextField.bottomAnchor, constant: 20),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
            
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
            checkLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            checkLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            checkLabel.heightAnchor.constraint(equalToConstant: 40),
            checkLabel.widthAnchor.constraint(equalToConstant: 40),
            checkLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }

    private func setupButton() {
        self.view.addSubview(self.button)
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -100).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func isPassCorrect() throws {
        let check = FeedModel()
        
        if self.checkTextField.text != "" {
            if check.check(word: self.checkTextField.text!) {
                let ac = UIAlertController(title: "Верно!", message: "Ты все сделал правильно!", preferredStyle: .alert)
                let OKButton = UIAlertAction(title: "OK", style: .default)
                ac.addAction(OKButton)
                self.present(ac, animated: true)
                self.checkLabel.backgroundColor = .green
            } else {
                throw CustomError.wrongPassword
            }
        } else {
            throw CustomError.emptyTextField
        }
    }

    
    private func checkPass() {
        do {
            try isPassCorrect()
        } catch CustomError.emptyTextField {
            let ac = UIAlertController(title: "Пусто", message: "Поле не заполнено", preferredStyle: .alert)
            let OKButton = UIAlertAction(title: "ОК", style: .default)
            ac.addAction(OKButton)
            self.present(ac, animated: true)
        } catch {
            let ac = UIAlertController(title: "Ошибка", message: "Не верно слово!", preferredStyle: .alert)
            let OKButton = UIAlertAction(title: "Попробовать снова", style: .default)
            ac.addAction(OKButton)
            self.present(ac, animated: true)
            self.checkLabel.backgroundColor = .red
        }
    }
 

    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc private func tap() {
        output?.showPost()
    }

    @objc private func check() {
        let check = FeedModel()
        
        if checkTextField.text != "" {
            if check.check(word: checkTextField.text!) {
                let ac = UIAlertController(title: "Верно!", message: "Вы все сделал правильно!", preferredStyle: .alert)
                let OKButton = UIAlertAction(title: "OK", style: .default)
                ac.addAction(OKButton)
                present(ac, animated: true)
                checkLabel.backgroundColor = .green
            } else {
                let ac = UIAlertController(title: "Ошибка", message: "Не верно слово!", preferredStyle: .alert)
                let OKButton = UIAlertAction(title: "Ок", style: .default)
                ac.addAction(OKButton)
                present(ac, animated: true)
                checkLabel.backgroundColor = .systemRed
            }
        } else {
            let ac = UIAlertController(title: "Поле не заполнено", message: "Введите слово", preferredStyle: .alert)
            let OKButton = UIAlertAction(title: "ОК", style: .default)
            ac.addAction(OKButton)
            present(ac, animated: true)
        }
    }
   
}

extension FeedViewController: FeedOutput {
    
    func showPost() {
        output?.showPost()
    }
}
