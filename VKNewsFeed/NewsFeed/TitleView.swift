//
//  TitleView.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 16.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit


protocol TitleViewViewModel {
    var photoUrl: String? { get }
}

class TitleView: UIView {
    
    private var textField = InsetableTextField()
    
    private var myAvatarView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        imageView.clipsToBounds = true
    
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myAvatarView)
        addSubview(textField)
        makeConstraints()
    }
    
    func set(userViewModel:TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrl)
    }
    
    private func makeConstraints() {
        myAvatarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1.0).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1.0).isActive = true
        myAvatarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: myAvatarView.leadingAnchor, constant: -4).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
        myAvatarView.clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
