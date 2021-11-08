//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Виктор Попов on 06.07.2021.
//  Copyright © 2021 Виктор Попов. All rights reserved.
//

import Foundation

protocol  Networking {
    func request(path: String, params:[String:String], completion: @escaping (Data?, Error?)->Void)
    
}

final class NetworkService: Networking {
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        //let session = URLSession.init(configuration: .default) через shared делаем своб конфигурацию
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?)->Void) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data,error)
            }
        }
    }

    private let authService: AuthService
    init(authService: AuthService = SceneDelegate.share().authSevice) {
        self.authService = authService
    }

    private func url(from path: String, params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }//имеет словарь,первое значение в $0 второе значение в $1
        
       return components.url!
    }
}
