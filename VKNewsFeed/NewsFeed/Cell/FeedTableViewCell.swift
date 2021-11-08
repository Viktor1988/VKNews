////
////  FeedTableViewCell.swift
////  VKNewsFeed
////
////  Created by Виктор Попов on 12.07.2021.
////  Copyright © 2021 Виктор Попов. All rights reserved.
////
//
//import UIKit
//
//protocol FeedCellViewModel {
//    var iconUrlString: String { get }
//    var name: String { get }
//    var date: String { get }
//    var text: String? { get }
//    var likes: String? { get }
//    var comments: String? { get }
//    var shares: String? { get }
//    var views: String? { get }
//    var photoAttachment: FeedCellPtohoAttechmentViewModel? { get }
//    var sizes: FeedCellSizes { get }
//}
//
//protocol FeedCellSizes {
//    var postLabelFrame: CGRect { get }
//    var attachmentFrame: CGRect { get }
//    var bottomView: CGRect { get }
//    var totalHeight: CGFloat { get }
//}
//
//protocol FeedCellPtohoAttechmentViewModel {
//    var photoUrlString: String? { get }
//    var height: Int { get }
//    var width: Int { get }
//    
//}
//
//class FeedTableViewCell: UITableViewCell {
//
//    static let reuseID = "FeedTableViewCell"
//    
//    @IBOutlet weak var generalView: UIView!
//    
//    @IBOutlet weak var imageViewIcon: WebImageView!
//    @IBOutlet weak var namePostLabel: UILabel!
//    @IBOutlet weak var datePostLabel: UILabel!
//    @IBOutlet weak var generalPostLabel: UILabel!
//    @IBOutlet weak var postImageView: WebImageView!
//    @IBOutlet weak var likePostLabel: UILabel!
//    @IBOutlet weak var commentPostLabel: UILabel!
//    @IBOutlet weak var sharePostLabel: UILabel!
//    @IBOutlet weak var eyePostLabel: UILabel!
//    @IBOutlet weak var viewDown: UIView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//  
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        imageViewIcon.layer.cornerRadius = imageViewIcon.frame.width / 2
//        imageViewIcon.clipsToBounds = true
//        
//        generalView.layer.cornerRadius = 10
//        generalView.clipsToBounds = true
//        
//        backgroundColor = .clear
//        selectionStyle = .none
//    }
//    
//      func set(viewModel: FeedCellViewModel) {
//            imageViewIcon.set(imageURL: viewModel.iconUrlString)
//            namePostLabel.text = viewModel.name
//            datePostLabel.text = viewModel.date
//            generalPostLabel.text = viewModel.text
//            likePostLabel.text = viewModel.likes
//            commentPostLabel.text = viewModel.comments
//            sharePostLabel.text = viewModel.shares
//            eyePostLabel.text = viewModel.views
//            
////            generalPostLabel.frame = viewModel.sizes.postLabelFrame
////            postImageView.frame = viewModel.sizes.attachmentFrame
////            viewDown.frame = viewModel.sizes.bottomView
//
//            
//            if let photoAttachment = viewModel.photoAttachment {
//                postImageView.set(imageURL: photoAttachment.photoUrlString)
//                postImageView.isHidden = false
//            } else {
//                postImageView.isHidden = true
//            }
//        }
//        
//    
//}
