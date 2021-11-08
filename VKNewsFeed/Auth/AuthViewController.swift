//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 06.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.share().authSevice
        view.backgroundColor = .green
    }
    
    @IBAction func singinTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

