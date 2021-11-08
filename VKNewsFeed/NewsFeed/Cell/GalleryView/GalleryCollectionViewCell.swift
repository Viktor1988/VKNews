//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 15.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit
class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    let myImageView : WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
        myImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        myImageView.layer.shadowRadius = 3
        myImageView.layer.shadowOpacity = 0.3
        myImageView.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
