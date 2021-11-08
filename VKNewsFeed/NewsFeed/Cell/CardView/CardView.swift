//
//  CardView.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 13.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

class CardView: UIView {

 public   func createCardView()->UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }
}

//    let cardView: UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//        return view
//    }()
