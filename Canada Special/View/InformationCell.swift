//
//  InformationCell.swift
//  Canada Special
//
//  Created by Nishanth Murugan on 19/09/18.
//  Copyright © 2018 WIPRO. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class InformationCell: UITableViewCell {
    var thumbnail = UIImageView(image: UIImage(named: "Placeholderico.png"))
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    let customCellView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.addSubview(customCellView)
        customCellView.addSubview(self.thumbnail)
        customCellView.addSubview(self.titleLabel)
        customCellView.addSubview(self.descriptionLabel)
        setFontsToLables()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFontsToLables() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.textColor = UIColor(red: 0, green: 0.67, blue: 0.56, alpha: 1)
        self.descriptionLabel.textColor = UIColor.gray
    }
    
    func setConstraints() {
        // Disable default constaints
        self.customCellView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints to customCellView
        self.customCellView.topAnchor.constraint(equalTo: self.topAnchor, constant : 16).isActive = true
        self.customCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant : 16).isActive = true
        self.customCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant : -16).isActive = true
        self.customCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant : -16).isActive = true
        
        // customCellView Rounded Corner
        self.customCellView.backgroundColor = .white
        self.customCellView.layer.cornerRadius = 6
        self.customCellView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.customCellView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        self.customCellView.layer.shadowOpacity = 1
        self.customCellView.layer.shadowRadius = 10
        self.customCellView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        self.customCellView.layer.borderWidth = 1.0
        
        // constraints to imageview
        self.thumbnail.topAnchor.constraint(equalTo: self.customCellView.topAnchor, constant: 4).isActive = true
        self.thumbnail.leftAnchor.constraint(equalTo: self.customCellView.leftAnchor, constant: 4).isActive = true
        self.thumbnail.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
        self.thumbnail.heightAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
        self.thumbnail.bottomAnchor.constraint(lessThanOrEqualTo: self.customCellView.bottomAnchor, constant: -4).isActive = true
        
        // Circle ImageView
        self.thumbnail.layer.borderWidth=1.0
        self.thumbnail.layer.masksToBounds = false
        self.thumbnail.layer.borderColor = UIColor.white.cgColor
        self.thumbnail.contentMode = UIViewContentMode.scaleAspectFill
        self.thumbnail.layer.cornerRadius = 50
        self.thumbnail.clipsToBounds = true
        self.thumbnail.layer.borderWidth = 3
        self.thumbnail.layer.borderColor = UIColor(red: 0, green: 0.67, blue: 0.56, alpha: 1).cgColor
       
        // constraints to Title
        self.titleLabel.topAnchor.constraint(equalTo: customCellView.topAnchor, constant: 10).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 8).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: customCellView.trailingAnchor).isActive = true
        self.titleLabel.numberOfLines = 0
        
        // constraints to Description
        self.descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 8).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: customCellView.trailingAnchor, constant: -8).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: customCellView.bottomAnchor,constant: -5 ).isActive = true
        self.descriptionLabel.numberOfLines = 0
    }
    
    // Download the image from url asyncronously and store in cache memory for resuse
    func loadThumbnail(url: String) {
        thumbnail.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Placeholderico.png"))
    }
    
}
