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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(self.thumbnail)
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.descriptionLabel)
        setFontsToLables()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFontsToLables() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.textColor = UIColor.white
        self.descriptionLabel.textColor = UIColor.gray
        self.backgroundColor = UIColor.black
    }
    
    func setConstraints() {
        // Disable default constaints
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints to imageview
        self.thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.thumbnail.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        self.thumbnail.widthAnchor.constraint(equalToConstant: CGFloat(150)).isActive = true
        self.thumbnail.heightAnchor.constraint(equalToConstant: CGFloat(180)).isActive = true
        let thumbnailBottomConstraint = self.thumbnail.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 0)
        thumbnailBottomConstraint.priority = .defaultHigh
        thumbnailBottomConstraint.isActive = true
        
        // constraints to Title
        self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 5).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.titleLabel.numberOfLines = 0
        
        // constraints to Description
        self.descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 5).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,constant: -5 ).isActive = true
        thumbnailBottomConstraint.priority = .defaultLow
        self.descriptionLabel.numberOfLines = 0
    }
    
    // Download the image from url asyncronously and store in cache memory for resuse
    func loadThumbnail(url: String) {
        thumbnail.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Placeholderico.png"))
    }
    
}
