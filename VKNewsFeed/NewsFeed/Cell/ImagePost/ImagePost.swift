//
//  ImagePost.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 13.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

class ImagePost: WebImageView {
    
    static func createImageView()->WebImageView {
        let imageView = WebImageView()
        return imageView
    } 
}

//    let viewContentImageView: WebImageView = {
//        let imageView = WebImageView()
////        imageView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
//        //imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
