//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 15.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation
import  UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var photos = [FeedCellPtohoAttechmentViewModel]()
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        
        
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
        
    }
    
    func set(photo: [FeedCellPtohoAttechmentViewModel]) {
        self.photos = photo
        contentOffset = CGPoint.zero//обнудяем,чтобы для новой коллекции координаты считались заново
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
