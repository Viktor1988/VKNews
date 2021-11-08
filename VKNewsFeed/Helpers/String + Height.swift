//
//  String + Height.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 12.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
