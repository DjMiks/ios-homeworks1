//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.08.2022.
//

import UIKit
import iOSIntPackage

private enum CollectionCellReuseID: String {
    case base = "CollectionCellReuseID_ReuseID"
}

 final class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    
    // MARK: DATA

    fileprivate lazy var  photoCollection: [AllPhotos] = AllPhotos.myPhotos()
     
     let facade = ImagePublisherFacade()
     
     var imageFromPublisher: [UIImage] = []
     
     let photo: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!,
                             UIImage(named: "11")!,UIImage(named: "12")!,UIImage(named: "13")!,UIImage(named: "14")!,UIImage(named: "15")!]
     

    // MARK: SubView
       
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
        facade.subscribe(self)
        facade.addImagesWithTimer(time: 0.5, repeat: 15, userImages: photo)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        facade.removeSubscription(for: self)
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
        imageFromPublisher.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellReuseID.base.rawValue, for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("cloud not dequeueReusableCell")
        }
        
      //  let photo = photoCollection[indexPath.row]
        cell.photoPreview.image = imageFromPublisher[indexPath.row]
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

extension PhotosViewController {
    func receive(images: [UIImage]) {
        imageFromPublisher = images
        collectiontView.reloadData()
    }
}
