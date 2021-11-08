//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 07.07.2021.
//  Copyright (c) 2021 Виктор Попов. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    
    
    //можно уалять, переписаны в worker
    
//    private var revealPostIds = [Int]()
//    private var feedResponse: FeedResponse?
//    private var userResponse: UserResponse?
//    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (revealPostIds, feed) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds)
                    
                )
            })
        case .revealPostIds(postId: let postId):
            service?.revealPostIds(forPostId: postId, completion: { [weak self] (revealPostIds , feed) in
                self? .presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUser(user: user))
            })
        case .getNextBatch:
//            print("123")
            self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentFooterLoader)
            service?.getNextBatch(completion: { (revealPostIds, feed) in
                self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
        }
        
        
        //можно удалить, переписано в worker
//        switch request {
//
//        case .getNewsFeed:
//            fetcher.getFeed {[weak self] (feedResponse) in
//                //            feedResponse?.items.map({ (feedItem) in
//                //                print("feedItem: \(feedItem)")
//                //            })
//                self?.feedResponse = feedResponse
//                self?.presenterFeed()
//            }
//        case .getUser:
//            fetcher.getUser { (userResponse) in
//                print("userResponse: \(String(describing: userResponse))")
//                self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUser(user: userResponse))
//            }
//        case .revealPostIds(postId: let postId):
//            print("revealPostIds")
//            revealPostIds.append(postId)
//            presenterFeed()
//        }

    }
    //переписали в worker
//    private func presenterFeed() {
//        guard let feedResponse = feedResponse else { return }
//        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse, revealPostIds: revealPostIds))
//    }
    
}
