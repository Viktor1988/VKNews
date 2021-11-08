//
//  NewsFeedViewController.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 07.07.2021.
//  Copyright (c) 2021 Виктор Попов. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, FeedNewsCodeTableViewCellDelegate {
    
    func revealPost(for cell: FeedNewsCodeTableViewCell) {
        print("revealPost")
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
    
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    
    
    
    @IBOutlet weak var table: UITableView!
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol  & NewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTopBars()
        setupTable()
        
        
        //
        //view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
        //        scrollViewDidScroll(<#UIScrollView#>)
        
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
    //            self.navigationController?.setNavigationBarHidden(false, animated: true)
    //            self.navigationController?.setToolbarHidden(false, animated: true)
    //        }
    //        else {
    //            self.navigationController?.setNavigationBarHidden(true, animated: true)
    //            self.navigationController?.setToolbarHidden(true, animated: true)
    //        }
    //    }
    
    private func setupTable() {
        table.register(UINib(nibName: "NewsFeedMyCell", bundle: nil), forCellReuseIdentifier: NewsFeedMyCell.reuseId)
        //        table.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: FeedTableViewCell.reuseID)
        table.register(FeedNewsCodeTableViewCell.self, forCellReuseIdentifier: FeedNewsCodeTableViewCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.addSubview(refreshControl)
        
        table.tableFooterView = footerView
        
    }
    private func setupTopBars() {
        let statusBarHeight: CGFloat = {
            var heightToReturn: CGFloat = 0.0
                 for window in UIApplication.shared.windows {
                     if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                         heightToReturn = height
                     }
                 }
            return heightToReturn
        }()
        
        let statusBarWidth: CGFloat = {
            var widthToReturn: CGFloat = 0.0
                 for window in UIApplication.shared.windows {
                     if let width = window.windowScene?.statusBarManager?.statusBarFrame.width, width > widthToReturn {
                         widthToReturn = width
                     }
                 }
            return widthToReturn
        }()
        
        let topBarFrame = CGRect(x: 0, y: 0, width: statusBarWidth, height: statusBarHeight)
        let topBar = UIView(frame: topBarFrame)
        
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowRadius = 8
        topBar.layer.shadowOffset = CGSize.zero
        
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            footerView.setTitle(feedViewModel.footerTitle)
            table.reloadData()
            refreshControl.endRefreshing()
            print("feedViewModel.footerTitle: \(feedViewModel.footerTitle!)")
        case .displayUser(let userViewModel):
            titleView.set(userViewModel: userViewModel)
        case .displayFooterLoader:
            footerView.showLoader()
        }
  
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNextBatch)
        }
    }
}

extension NewsFeedViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedMyCell.reuseId, for: indexPath) as? NewsFeedMyCell {
        //            let cellViewModel = feedViewModel.cells[indexPath.row]
        //            cell.set(viewModel: cellViewModel)
        //            return cell
        //        }
        //        return UITableViewCell()
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: FeedNewsCodeTableViewCell.reuseId, for: indexPath) as! FeedNewsCodeTableViewCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        myCell.set(viewModel: cellViewModel)
        myCell.delegate = self
        return myCell
        
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedMyCell.reuseId, for: indexPath) as! NewsFeedMyCell
        //        let cellViewModel = feedViewModel.cells[indexPath.row]
        //        cell.set(viewModel: cellViewModel)
        //        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("select Row: \(indexPath.row)")
    //        interactor?.makeRequest(request: .getFeed)
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row ]
        return cellViewModel.sizes.totalHeight
    }
}
