//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Максим Ялынычев on 20.08.2022.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    // MARK: SubView
    
     lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight:.bold)
        authorLabel.numberOfLines = 2
        authorLabel.textColor = .blue
        
         return authorLabel
    }()
    
     lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        
         return postImage
    }()
    
     lazy var postDescription: UILabel = {
       let postDescription = UILabel()
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        
        
         return postDescription
    }()
    
     lazy var numberOfLike: UILabel = {
       let numberOfLike = UILabel()
        numberOfLike.translatesAutoresizingMaskIntoConstraints = false
        numberOfLike.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfLike.textColor = .black
         return numberOfLike
    }()
    
     lazy var numberOfView: UILabel = {
       let numberOfView = UILabel()
        numberOfView.translatesAutoresizingMaskIntoConstraints = false
        numberOfView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfView.textColor = .black
        
        return numberOfView
    }()
    
     lazy var stackView: UIStackView = {
        let strackView = UIStackView()
        strackView.translatesAutoresizingMaskIntoConstraints = false
        strackView.clipsToBounds = true
        
        strackView.axis = .horizontal
        strackView.distribution = .equalSpacing
        strackView.alignment = .fill
        
        strackView.addArrangedSubview(numberOfLike)
        strackView.addArrangedSubview(numberOfView)
         return strackView
    }()
    
    // MARK: cycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupSubview()
        setupConstrainsts()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: privat metod
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }
    
    private func setupSubview() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(stackView)
    }
    private func setupConstrainsts() {
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -12),
        
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.bottomAnchor.constraint(equalTo: postDescription.topAnchor, constant: -16),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
        ])
    }
    
    
    // MARK: Publish Metod
    
    func setup(with post: PostTape){
        authorLabel.text = post.author
        postImage.image = UIImage(named: post.image)
        postDescription.text = post.description
        numberOfLike.text = String("Likes: \(post.likes)")
        numberOfView.text = String("Views: \(post.views)")
        
    // MARK: color filter
        
        let filter = ImageProcessor()
        guard let image = postImage.image else { return }

        filter.processImage(sourceImage: image, filter: .noir) {
             postImage.image = $0
        }
    }
}

