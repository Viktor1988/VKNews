//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 12.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(post: String?, photoAttachment:[FeedCellPtohoAttechmentViewModel], isFullSizedPost: Bool ) -> FeedCellSizes
}


struct  Constants {
    static let cardViewInsets = UIEdgeInsets(top: 12 , left: 9, bottom: 12, right: 9)
    static let topViewHeight : CGFloat = 60
    static let labelPostInsets = UIEdgeInsets(top: 12 + Constants.topViewHeight + 8 + 12, left: 8, bottom: 12, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 64
    static let bottomSubViewWidth: CGFloat = 76
    static let imageViewInBottomView: CGFloat = 24
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    
    static let topView: CGFloat = 60
    
    static let iconImageSize: CGFloat = 60
}
struct Sizes: FeedCellSizes {

    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol{
    
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(post: String?, photoAttachment photoAttachments: [FeedCellPtohoAttechmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        let cardViewWidth = screenWidth - Constants.cardViewInsets.left - Constants.cardViewInsets.right
        var showMoreTextButton = false
        
        // MARK -  работа с PostLabelFrame
        var postLableFrame = CGRect(origin: CGPoint(x: Constants.labelPostInsets.left, y: Constants.labelPostInsets.top), size: CGSize.zero)
        if let text = post, !text.isEmpty {
            
            let width = cardViewWidth - Constants.labelPostInsets.left - Constants.labelPostInsets.right
            var heigh = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            if heigh > limitHeight && !isFullSizedPost {
                heigh = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLableFrame.size = CGSize(width: width, height: heigh)
        }
        
        // MARK -  работа с moreTextButton
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLableFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK -  работа с attachmentFrame
        let attachmentTop = postLableFrame.size == CGSize.zero ? Constants.labelPostInsets.top : moreTextButtonFrame.maxY + Constants.labelPostInsets.bottom
        var attachmentFrame  = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                      size: CGSize.zero)
        
//        if let attachment = photoAttachment {
//            let photoHeight: Float = Float(attachment.height)
//            let photoWidth: Float = Float(attachment.width)
//            let ratio = CGFloat(photoHeight / photoWidth)
//            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
//        }
        
        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: photo.width, height: photo.height)
                    photos.append(photoSize)
                }
                
                let rowHeigt = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photoArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeigt!)
                //attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            }
        }

        // MARK -  работа с bottomViewFrame
        let bottomViewTop = max(postLableFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        
        // MARK -работа с totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardViewInsets.bottom
        
        return Sizes(postLabelFrame: postLableFrame,
                    moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
