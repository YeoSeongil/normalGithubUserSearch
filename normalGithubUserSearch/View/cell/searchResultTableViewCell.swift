//
//  searchResultTableViewCell.swift
//  normalGithubUserSearch
//
//  Created by 여성일 on 2/6/24.
//

import UIKit

class searchResultCollectionViewCell: UICollectionViewCell {

    static let id:String  = "searchResultCollectionViewCell"
    
    var users: Item? {
        didSet {
            configuration()
        }
    }
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        self.setConstaraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setView() {
        [userImageView, nameLabel].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .clear
        self.layer.cornerRadius = CGFloat(5)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setConstaraint() {
        userImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -15).isActive = true
        //userImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        //userImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    }

    func configuration() {
        guard let users else { return }
       //self.userImageView.image = UIImage(named: users.items[0].avatarURL)
        self.userImageView.setImageKingfisher(with: users.avatarURL)
        self.nameLabel.text = users.login
    }
}
