//
//  PostLabel.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 13.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

class PostLabel: UILabel {
    static  func create()-> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        return label
    }
}

////    let contentPostLabel: UILabel = {
//        let label = UILabel()
////        label.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//        label.numberOfLines = 0
//        label.font = Constants.postLabelFont
//        //label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
