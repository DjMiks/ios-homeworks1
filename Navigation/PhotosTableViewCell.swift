//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.08.2022.
//

import UIKit

//MARK: Subview

class PhotosTableViewCell: UITableViewCell {

    private lazy var photosTitle: UILabel = {
        
        let photosTitle = UILabel()
        photosTitle.translatesAutoresizingMaskIntoConstraints = false
        
        photosTitle.textColor = .black
        photosTitle.font = UIFont.systemFont (ofSize: 24, weight: .bold)
        photosTitle.text = "My Photo"
         return photosTitle
    }()

        private lazy var photosArrow: UIImageView = {
           let photosArrow = UIImageView()
            photosArrow.translatesAutoresizingMaskIntoConstraints = false
            
           let image = UIImage(systemName: "arrow.riaht")?.withTintColor(.black,renderingMode:.alwaysOriginal)
            photosArrow.image = image
              return photosArrow
    }()
    
    private lazy var titleStrackView: UIStackView = {
        let titleStackView = UIStackView()
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.distribution = .equalSpacing
        titleStackView.alignment = .center
        
        titleStackView.addArrangedSubview(photosTitle)
        titleStackView.addArrangedSubview(photosArrow)
         return titleStackView
    }()
    
    private lazy var photo1: UIImageView = {
        let photo1 = UIImageView()
        photo1.translatesAutoresizingMaskIntoConstraints = false
        photo1.image = UIImage(named: "1")
        photo1.contentMode = .scaleAspectFill
        photo1.layer.cornerRadius = 6
        photo1.clipsToBounds = true
         return photo1
        
    }()
    
    private lazy var photo2: UIImageView = {
        let photo2 = UIImageView()
        photo2.translatesAutoresizingMaskIntoConstraints = false
        photo2.image = UIImage(named: "2")
        photo2.contentMode = .scaleAspectFill
        photo2.layer.cornerRadius = 6
        photo2.clipsToBounds = true
         return photo2
    }()
    
    private lazy var photo3: UIImageView = {
        let photo3 = UIImageView()
        photo3.translatesAutoresizingMaskIntoConstraints = false
        photo3.image = UIImage(named: "3")
        photo3.contentMode = .scaleAspectFill
        photo3.layer.cornerRadius = 6
        photo3.clipsToBounds = true
         return photo3
        
    }()
    private lazy var photo4: UIImageView = {
        let photo4 = UIImageView()
        photo4.translatesAutoresizingMaskIntoConstraints = false
        photo4.image = UIImage(named: "4")
        photo4.contentMode = .scaleAspectFill
        photo4.layer.cornerRadius = 6
        photo4.clipsToBounds = true
         return photo4
    }()
    
    private lazy var photoStackView: UIStackView = {
       let photoStackView = UIStackView ()
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        photoStackView.axis = .horizontal
        photoStackView.distribution = .fillEqually
        photoStackView.alignment = .fill
        photoStackView.spacing = 8
        
        photoStackView.addArrangedSubview(photo1)
        photoStackView.addArrangedSubview(photo2)
        photoStackView.addArrangedSubview(photo3)
        photoStackView.addArrangedSubview(photo4)
         return photoStackView
    }()
    
    // MARK: CYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
    }
    private func setupSubview() {
        contentView.addSubview(titleStrackView)
        contentView.addSubview(photoStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleStrackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleStrackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleStrackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            photoStackView.topAnchor.constraint(equalTo: titleStrackView.bottomAnchor, constant: 12),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStackView.heightAnchor.constraint(equalToConstant: 90),
        ])
        
    }
}
