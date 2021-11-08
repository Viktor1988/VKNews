//
//  NewsFeedPresenter.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 07.07.2021.
//  Copyright (c) 2021 Виктор Попов. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
     
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    var dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(feed: let feed, let revealedPostIds):
            print("revealedPostIds: \(revealedPostIds)")
            
            let cells = feed.items.map { (feedItem) in
                cellViewModel(feedItem: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""), cells.count)
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feed: feedViewModel))
        case .presentUser(user: let user):
            let userViewModel = UserViewModel.init(photoUrl: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(user: userViewModel))
        case .presentFooterLoader:
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayFooterLoader)
        }
    }
    
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int])->FeedViewModel.Cell {
        
//        let profile = self.profile(forsourceID: feedItem.sourceId, profiles: profiles, groups: groups)
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        //let photoAttachment = self.photoAttechment(feetItem: feedItem)
        
        let photoAttachments =  self.photoAttechments(feetItem: feedItem)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
//        let isFullSized = revealedPostIds.contains { (postId) -> Bool in
//            return postId == feedItem.postId
//        }
        
        let isFullSized = revealedPostIds.contains(feedItem.postId)
        
        let sizes =  cellLayoutCalculator.sizes(post: feedItem.text, photoAttachment: photoAttachments, isFullSizedPost: isFullSized)
        
        let  postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        return FeedViewModel.Cell.init(postId: feedItem.postId, iconUrlString: profile.photo,
                                       name: profile.name ,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    
    
    private func formattedCounter(_ counter: Int?)->String? {
        guard let counter = counter, counter > 0 else { return nil}
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
        
    }
    
    private func profile(for sourceID: Int, profiles:[Profile], groups:[Group]) -> ProfileRepresentable {
        let profileOrGroups: [ProfileRepresentable] = sourceID >= 0 ? profiles : groups
        let normalSourceId = sourceID >= 0 ? sourceID : -sourceID
        let profileRepresenatable = profileOrGroups.first { (myProfileRepresenatable) -> Bool in
            myProfileRepresenatable.id == normalSourceId
        }
        return profileRepresenatable!
    }
    
    private func photoAttechment(feetItem: FeedItem) -> FeedViewModel.FeedCellPtohoAttechment? {
        guard let photos = feetItem.attachments?.compactMap({(attachment) in attachment.photo }), let firstPhoto = photos.first else { return nil}
        return FeedViewModel.FeedCellPtohoAttechment.init(photoUrlString: firstPhoto.srcBig, height: firstPhoto.height, width: firstPhoto.width)
    }
     
    private func photoAttechments(feetItem: FeedItem) -> [FeedViewModel.FeedCellPtohoAttechment] {
        guard let attachments = feetItem.attachments else { return [] }
        return attachments.compactMap({ (attechment) -> FeedViewModel.FeedCellPtohoAttechment? in
            guard let photo = attechment.photo else { return nil}
            return FeedViewModel.FeedCellPtohoAttechment.init(photoUrlString: photo.srcBig, height: photo.height, width: photo.width)
        })
    }
    
}
