//
//  PullManager.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/17.
//

import Foundation

protocol IssueService {
    var currentParameter: IssuesParameter { get set }
    func getIssues(then completion: @escaping ([Issue]?) -> Void)
    func close(issueId: Int, completion: @escaping (Issue?) -> Void)
}

struct IssueManager: IssueService {
    
    let keyChainService: KeyChainService
    let networkService: NetworkService
    
    init(keyChainService: KeyChainService = KeyChainManager(),
         networkService: NetworkService = NetworkManger()) {
        self.keyChainService = keyChainService
        self.networkService = networkService
    }
    
    private var issueStorage = Storage<Int, Issue>()
    var currentParameter: IssuesParameter = IssuesParameter.standard
    
    
    // MARK: - Get Issues
    
    func getIssues(then completion: @escaping ([Issue]?) -> Void) {
        guard let token = getAccessToken() else {
            return completion(nil)
        }
        
        let request = makeGetRequest(token: token)
        
        networkService.execute(request) { result in
            switch result {
            case .success(let issues):
                updateStorage(issues)
                completion(issues)
            case .failure(let error):
                Log.error(error.localizedDescription + "(\(#file), \(#function), \(#line))")
                completion(nil)
            }
        }
    }
    
    private func getAccessToken() -> String? {
        guard let accessToken = keyChainService.load(service: "access-token", account: "github") else {
            Log.error("Access Token is not found")
            return nil
        }
        return accessToken
    }
    
    private func makeGetRequest(token: String) -> APIRequest<GetIssues> {
        let endpoint = GetIssues(parameter: self.currentParameter)
        return APIRequest(endpoint: endpoint, token: token)
    }
    
    private func updateStorage(_ issues: [Issue]) {
        issueStorage.remove()
        issues.forEach { issue in issueStorage.value[issue.id] = issue }
    }
}

// MARK: - Close Issue

extension IssueManager {
    func close(issueId: Int, completion: @escaping (Issue?) -> Void) {
        guard let issue = retriveIssue(id: issueId),
              let token = getAccessToken() else {
            return completion(nil)
        }
        
        let request = makeCloseRequest(issue: issue, token: token)
        
        networkService.execute(request) { result in
            switch result {
                
            case .success(let issue):
                Log.info("\(issue)")
                completion(issue)
            case .failure(let error):
                Log.error(error.localizedDescription + "(\(#file), \(#function), \(#line))")
                completion(nil)
            }
        }
    }
    
    private func makeCloseRequest(issue: Issue, token: String) -> APIRequest<UpdateIssue> {
        let body = "{\"state\":\"closed\"}"
        let endpoint = UpdateIssue(issue: issue)
        return APIRequest(endpoint: endpoint, token: token, body: body)
    }
    
    private func retriveIssue(id: Int) -> Issue? {
        guard let issue = issueStorage.value[id] else {
            Log.error("Wrong issue id")
            return nil
        }
        return issue
    }
}
