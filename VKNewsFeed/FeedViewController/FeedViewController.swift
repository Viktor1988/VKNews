//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 06.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit
class FeedViewController: UIViewController {
    
    private let networkService: NetworkService = NetworkService()
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
//        fetcher.getFeed { (feedResponse ) in
//            guard let feedResponse = feedResponse else { return }
//            feedResponse.items.map ({(feedItem) in
//                print(feedItem.date)
//            })
//        }
    }
}
