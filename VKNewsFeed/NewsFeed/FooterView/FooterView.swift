//
//  FooterView.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 19.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit
class FooterView: UIView {
    
    private let myLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myLabel)
        addSubview(loader)
        makeConstraint()
    }
    
    private func makeConstraint() {
        myLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        myLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: -4).isActive = true

        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
//        myLabel.anchor(top: topAnchor,
//                              leading: leadingAnchor,
//                              bottom: nil,
//                              trailing: trailingAnchor,
//                              padding: UIEdgeInsets(top: 8, left: 20, bottom: 777, right: 20))
//
//               loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//               loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
    }
    
     func showLoader() {
        loader.startAnimating()
    }
    
     func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
