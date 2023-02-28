//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 28.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var output: FeedOutput?
    
    fileprivate lazy var data = PostTape.make()

    var viewModel: ProfileVIewModel! {
        didSet {
            self.data = viewModel.model ?? []
        }
    }
    
    var currenUser: User? = nil
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init (frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableView_ReuseID"
        case photos = "PhotosTableView_ReuseID"
    }
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
        
    }
  
// MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
        tuneTableView()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//    }
    
    // MARK: METOD
    
    private func setupView() {
//        #if DEBUG
//        view.backgroundColor = .systemYellow
//        #else
//        view.backgroundColor = .systemGreen
//        #endif
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
     func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        tableView.register(
            PhotosTableViewCell.self,
        forCellReuseIdentifier:CellReuseID.photos.rawValue
        )
        
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: extension

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.photos.rawValue, for: indexPath) as? PhotosTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.base.rawValue, for:indexPath)
                as? PostTableViewCell else {
            fatalError("cloud not dequeueReusableCell")
        }
        
        let data = data[indexPath.row]
        cell.setup(with: data)
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250 }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterReuseID.base.rawValue) as? ProfileTableHeaderView else {
            fatalError("could not dequeueReusableCell")
        }
        if let currentUser = currenUser {
        headerView.setup(fullName: currentUser.fullName, statusText: currentUser.status, avatar: currentUser.avatar)
        }
        return headerView
        } else {
            let emtyHeader = UIView()
            return emtyHeader
        }
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let nextViewController = PhotosViewController()
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
