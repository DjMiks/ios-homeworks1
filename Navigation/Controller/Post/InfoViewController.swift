//
//  InfoViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resNames: [String] = []
    
     
  private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title is loading, please wait..."
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()

   private lazy var tatooineOrbitalPeriodLabel: UILabel = {
        let tatooineOrbitalPeriodLabel = UILabel()
        tatooineOrbitalPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        tatooineOrbitalPeriodLabel.text = "Calculating..."
        tatooineOrbitalPeriodLabel.textColor = .white
        
        return tatooineOrbitalPeriodLabel
    }()

     

    
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
        
        setupSubview()
        setTitleLabelText()
        setTatooineOrbitalPeriodLabelText()
        
        
//        view.addSubview(button)
//        button.sizeToFit()
//        button.center = view.center
//
    }
    
    // MARK: - Setup view

    private func setupSubview() {
        view.addSubview(titleLabel)
        view.addSubview(tatooineOrbitalPeriodLabel)
        view.addSubview(button)
         setupConstraints()
    }

        func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
                      
            tatooineOrbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tatooineOrbitalPeriodLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            tatooineOrbitalPeriodLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
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
    
    // MARK: - Task 1

    private func setTitleLabelText() {
        getTitle { title in
            DispatchQueue.main.async {
                self.titleLabel.text = title
            }
        }
    }

    // MARK: - Task 2

    private func setTatooineOrbitalPeriodLabelText() {
        getRotationPeriod { period in
            guard (period != nil) else { return }
            DispatchQueue.main.async {
                self.tatooineOrbitalPeriodLabel.text = "Tatooine orbital period is \(period!)"
            }
        }
    }


    // MARK: - Setup TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .systemGray6
        cell.textLabel?.text = self.resNames[indexPath.row]
        return cell
    }
}

class TableViewCell: UITableViewCell {
   
}
