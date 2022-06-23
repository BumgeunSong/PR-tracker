//
//  LoginViewModel.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/13.
//

import Foundation

final class LoginViewModel {
    
    let githubLoginManager = GitHubLoginManager()
    
    let authorizationStatus: Observable<AuthorizationStatus> = Observable(.none)
    
    init(githubLoginManager: GitHubLoginManager = GitHubLoginManager.shared, initalStatus: AuthorizationStatus = .none) {
        githubLoginManager.loginStatus.bind { [weak self] status in
            self?.authorizationStatus.value = status
        }
    }
    
    func requestGithubLogin() {
        githubLoginManager.requestAuthorization()
    }
    
    func hasValidToken(completion: @escaping (Bool) -> Void) {
        githubLoginManager.hasValidToken { isValid in
            completion(isValid)
        }
    }
}
