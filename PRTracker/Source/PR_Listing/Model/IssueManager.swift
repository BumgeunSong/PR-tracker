//
//  PullManager.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/17.
//

import Foundation

protocol IssueService {
    func getIssues(then completion: @escaping ([Issue]?) -> Void)
}

struct IssueManager: IssueService {
    
    let keyChainService: KeyChainService
    let networkService: NetworkService
    
    init(keyChainService: KeyChainService = KeyChainManager(),
         networkService: NetworkService = NetworkManger()) {
        self.keyChainService = keyChainService
        self.networkService = networkService
    }
    
    func getIssues(then completion: @escaping ([Issue]?) -> Void) {
        guard let accessToken = keyChainService.load(service: "access-token", account: "github") else {
            Log.error("Access Token is not found")
            return completion(nil)
        }
        
        guard let url = URL(string: BaseURL.issues) else {
            Log.error("Wrong Base URL: \(BaseURL.issues)")
            return completion(nil)
        }
        
        let request = URLRequest(url: url, with: accessToken)
        
        networkService.request(request, then: completion)
    }
}

