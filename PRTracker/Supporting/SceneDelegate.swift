//
//  SceneDelegate.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let code = parseCode(from: URLContexts) else { return }
        GitHubLoginManager.shared.requestAccessToken(with: code)
    }
    
    private func parseCode(from URLContexts: Set<UIOpenURLContext>) -> String? {
        guard let url = URLContexts.first?.url,
              url.absoluteString.starts(with: "pr-tracker://"),
              let queryString = url.query,
              let code = queryString.components(separatedBy: "=").last else { return nil }
        return code
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
