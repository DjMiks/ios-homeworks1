//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.08.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: DATA

    fileprivate lazy var  photoCollection: [AllPhotos] = AllPhotos.myPhotos()

    // MARK: SubView
    
    private enum CollectionCellReuseID: String {
        case base = "CollectionCellReuseID_ReuseID"
    }
    
    private let collectiontView: UICollectionView = {
       let viewFlowLayout = UICollectionViewFlowLayout()
       let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: viewFlowLayout
       )
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CollectionCellReuseID.base.rawValue)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubview()
        setupConctraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Private
    
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        title = "Gallery"
    }
    
    private func setupSubview() {
        view.addSubview(collectiontView)
        
        collectiontView.dataSource = self
        collectiontView.delegate = self
        collectiontView.backgroundColor = .systemBackground
    }
    
    private func setupConctraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectiontView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectiontView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectiontView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectiontView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellReuseID.base.rawValue, for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("cloud not dequeueReusableCell")
        }
        
        let photo = photoCollection[indexPath.row]
        cell.setupMethod(with: photo)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * 8 + (itemsInRow - 1) * 8
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 8)
        return CGSize(width:width, height:width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
        top: 8, left: 8, bottom: 8, right: 8
        )
    }
    
     func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    
}
