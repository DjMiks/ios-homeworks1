//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.08.2022.
//

import UIKit


class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: Subviews
    
    lazy var photoPreview: UIImageView = {
        let photoPreview = UIImageView(frame: .zero)
        photoPreview.translatesAutoresizingMaskIntoConstraints = false
        photoPreview.contentMode = .scaleToFill
         return photoPreview
    }()
 // MARK: LifeCycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    // MARK: Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
    }
    private func setupSubview() {
        contentView.addSubview(photoPreview)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoPreview.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoPreview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoPreview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoPreview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupMethod(with photo: AllPhotos){
        photoPreview.image = UIImage(named: photo.photoImage)
    }
    
    
}
