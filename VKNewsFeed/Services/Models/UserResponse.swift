//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 16.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
