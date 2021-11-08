//
//  NewsFeedModels.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 07.07.2021.
//  Copyright (c) 2021 Виктор Попов. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case revealPostIds(postId: Int)
        case getUser
        case getNextBatch
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse,revealPostIds: [Int])
        case presentUser(user: UserResponse?)
        case presentFooterLoader
        
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feed: FeedViewModel)
        case displayUser(user: UserViewModel)
        case displayFooterLoader 
      }
    }
  }
}

struct UserViewModel: TitleViewViewModel {
    var photoUrl: String?
    
    
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        
        var postId: Int 
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPtohoAttechmentViewModel]
        var sizes: FeedCellSizes
    }
    struct FeedCellPtohoAttechment: FeedCellPtohoAttechmentViewModel {
        var photoUrlString: String?
        var height: Int
        var width: Int
    }
    
    let cells: [Cell]
    
    let footerTitle: String?
}
