//
//  NewsFeedMyCell.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 12.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import UIKit


protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPtohoAttechmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    
    var postLabelFrame: CGRect { get }
    var moreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPtohoAttechmentViewModel {
    var photoUrlString: String? { get }
    var height: Int { get }
    var width: Int { get }
    
}

class NewsFeedMyCell: UITableViewCell {
    
    static let reuseId = "NewsFeedMyCell"
    
    @IBOutlet weak var viewIconImageView: WebImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var contentPostLabel: UILabel!
    @IBOutlet weak var viewContentImageView: WebImageView!
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    @IBOutlet weak var labelShares: UILabel!
    @IBOutlet weak var labelViews: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    override func prepareForReuse() {
        viewIconImageView.set(imageURL: nil)
        viewContentImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
        viewIconImageView.layer.cornerRadius = viewIconImageView.frame.width / 2
        viewIconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        viewIconImageView.set(imageURL: viewModel.iconUrlString)
//        TitleLabel.text = viewModel.name
//        labelDate.text = viewModel.date
//        contentPostLabel.text = viewModel.text
//        labelLikes.text = viewModel.likes
//        labelComments.text = viewModel.comments
//        labelShares.text = viewModel.shares
//        labelViews.text = viewModel.views
//        
//        contentPostLabel.frame = viewModel.sizes.postLabelFrame
//        viewContentImageView.frame = viewModel.sizes.attachmentFrame
//        bottomView.frame = viewModel.sizes.bottomViewFrame 
//
//        if let photoAttachment = viewModel.photoAttachment {
//            viewContentImageView.set(imageURL: photoAttachment.photoUrlString)
//            viewContentImageView.isHidden = false
//        } else {
//            viewContentImageView.isHidden = true
//        }
//    }
    
}
