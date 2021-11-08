//
//  FeedNewsCodeTableViewCell.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 13.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

protocol FeedNewsCodeTableViewCellDelegate: AnyObject {
    func revealPost(for cell: FeedNewsCodeTableViewCell)
}

class FeedNewsCodeTableViewCell: UITableViewCell {
    
    static let reuseId = "FeedNewsCodeTableViewCell"
    
    weak var delegate:FeedNewsCodeTableViewCellDelegate?
    
    override func prepareForReuse() {
        viewIconImageView.set(imageURL: nil)
        viewContentImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addOnGeneralView()
        addOnCardView()
        addOnTopView()
        addOnBottomView()
        addOnViewOnBottomView()
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
    }
    
    override func layoutSubviews() {        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    // MARK: -Create basic view elements-
    let cardView = CardView().createCardView()

    let topView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let contentPostLabel = PostLabel.create()
    let viewContentImageView = ImagePost.createImageView()
    let galleryCollectionView = GalleryCollectionView()
    
    let contentPostLabel: UITextView = {
      let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding )
        return textView
    }()
    
    let moreTextButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.08025838174, green: 0.4498003596, blue: 1, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let bottomView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -Create top view elements-
    let viewIconImageView: WebImageView = {
        let imageView = WebImageView()
//        imageView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let TitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    // MARK: -Create bottom view elements-
    let viewLikes: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "like")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let labelLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewComments: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let commentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "comment")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let labelComments: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewShares: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sharesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let labelShares: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewEye: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eye")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let labelViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    // #MARK: -add on Basic View and setting constraint for elements-
    func addOnGeneralView(){
        addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.cardViewInsets.top).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.cardViewInsets.left).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.cardViewInsets.right).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.cardViewInsets.bottom).isActive = true
    }
    
    // #MARK: -add on CardView and setting constraint for elements-
    func addOnCardView() {
        cardView.addSubview(topView)
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        cardView.addSubview(contentPostLabel)
        //        contentPostLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8).isActive = true
        //        contentPostLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        //        contentPostLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        //        contentPostLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cardView.addSubview(moreTextButton)
        
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(viewContentImageView)
        //        viewContentImageView.topAnchor.constraint(equalTo: contentPostLabel.bottomAnchor, constant: 8).isActive = true
        //        viewContentImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0).isActive = true
        //        viewContentImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
        //        viewContentImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        cardView.addSubview(bottomView)
    }
    
    // #MARK: -add on TopView and setting constraint for elements-
    func addOnTopView() {
        topView.addSubview(viewIconImageView)
        viewIconImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        viewIconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        viewIconImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        viewIconImageView.widthAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        
        topView.addSubview(TitleLabel)
        TitleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: viewIconImageView.trailingAnchor, constant: 10).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        topView.addSubview(labelDate)
        labelDate.leadingAnchor.constraint(equalTo: viewIconImageView.trailingAnchor, constant: 10).isActive = true
        labelDate.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -4).isActive = true
        labelDate.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
        labelDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    // #MARK: -add on BottomView and setting constraint for elements-
    func addOnBottomView() {
        bottomView.addSubview(viewLikes)
        viewLikes.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        viewLikes.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0).isActive = true
        viewLikes.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        viewLikes.widthAnchor.constraint(equalToConstant: Constants.bottomSubViewWidth).isActive = true
        
        bottomView.addSubview(viewComments)
        viewComments.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        viewComments.leftAnchor.constraint(equalTo: viewLikes.rightAnchor, constant: 0).isActive = true
        viewComments.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        viewComments.widthAnchor.constraint(equalToConstant: Constants.bottomSubViewWidth).isActive = true
        
        bottomView.addSubview(viewShares)
        viewShares.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        viewShares.leftAnchor.constraint(equalTo: viewComments.rightAnchor, constant: 0).isActive = true
        viewShares.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        viewShares.widthAnchor.constraint(equalToConstant: Constants.bottomSubViewWidth).isActive = true
        
        bottomView.addSubview(viewEye)
        viewEye.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        viewEye.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: 0).isActive = true
        viewEye.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        viewEye.widthAnchor.constraint(equalToConstant: Constants.bottomSubViewWidth).isActive = true
    }
    
    
    // #MARK: -add on View on BottomView and setting constraint for elements-
    func addOnViewOnBottomView() {
        viewLikes.addSubview(likesImage)
        viewLikes.addSubview(labelLikes)
        
        viewComments.addSubview(commentImage)
        viewComments.addSubview(labelComments)

        viewShares.addSubview(sharesImage)
        viewShares.addSubview(labelShares)

        viewEye.addSubview(labelViews)
        viewEye.addSubview(viewsImage)

        createElementsOnViewOnBottomView(view: viewLikes, imageView: likesImage, label: labelLikes)
        createElementsOnViewOnBottomView(view: viewComments, imageView: commentImage, label: labelComments)
        createElementsOnViewOnBottomView(view: viewShares, imageView: sharesImage, label: labelShares)
        createElementsOnViewOnBottomView(view: viewEye, imageView: viewsImage, label: labelViews)
    }
    
    func createElementsOnViewOnBottomView(view: UIView, imageView: UIImageView, label: UILabel) {
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewInBottomView).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewInBottomView).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        viewIconImageView.layer.cornerRadius = viewIconImageView.frame.width / 2
        viewIconImageView.clipsToBounds = true
        
    }
    
    // MARK: -general functions-
    func set(viewModel: FeedCellViewModel) {
        viewIconImageView.set(imageURL: viewModel.iconUrlString)
        TitleLabel.text = viewModel.name
        labelDate.text = viewModel.date
        contentPostLabel.text = viewModel.text
        labelLikes.text = viewModel.likes
        labelComments.text = viewModel.comments
        labelShares.text = viewModel.shares
        labelViews.text = viewModel.views
        
        contentPostLabel.frame = viewModel.sizes.postLabelFrame
//        viewContentImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            viewContentImageView.set(imageURL: photoAttachment.photoUrlString)
            viewContentImageView.isHidden = false
            galleryCollectionView.isHidden = true
            viewContentImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            viewContentImageView.isHidden  = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photo: viewModel.photoAttachments)
        }
        else {
            viewContentImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    @objc
    func moreTextButtonTouch() {
        print("moreTextButtonTouch")
        delegate?.revealPost(for: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
