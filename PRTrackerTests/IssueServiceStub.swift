//
//  IssueServiceStub.swift
//  PRTrackerTests
//
//  Created by 안상희 on 2022/06/23.
//

import Foundation

struct IssueServiceSuccessStub: IssueService {
    var currentParameter: IssuesParameter = IssuesParameter.standard
    
    func getIssues(then completion: @escaping ([Issue]?) -> Void) {
        let user1 = User(id: 0, userName: "EddySong", reposURL: "url~")
        let user2 = User(id: 1, userName: "iOS-h", reposURL: "url!")
        let label1 = Label(id: 0, color: "Blue", name: "Documentation")
        let label2 = Label(id: 1, color: "Yello", name: "Refactor")
        let milestone = Milestone(id: 0, title: "마일스토온")
        let repo = Repository(id: 0, name: "test", fullName: "test/test")
        let model1 = Issue(id: 0,
                           number: 1,
                           title: "PR 제목입니당",
                           body: "작업 내용은 다음과 같습니다,,\n클릭해서 봐주세요..",
                           state: "상태1",
                           creator: user1,
                           assignees: [user1],
                           labels: [label1],
                           milestone: milestone,
                           pull: Pull(url: ""),
                           repository: repo
                           )
        let model2 = Issue(id: 1,
                           number: 2,
                           title: "PR 제목입니당2",
                           body: "작업 내용은 다음과 같습니다,,\n클릭해서 봐주세욤",
                           state: "상태2",
                           creator: user2,
                           assignees: [user1, user2],
                           labels: [label1, label2],
                           milestone: milestone,
                           pull: Pull(url: ""),
                           repository: repo
                           )
        completion([model1, model2])
    }
    
    func close(issueId: Int, completion: @escaping (Issue?) -> Void) {
        let user1 = User(id: 0, userName: "EddySong", reposURL: "url~")
        let label1 = Label(id: 0, color: "Blue", name: "Documentation")
        let milestone = Milestone(id: 0, title: "마일스토온")
        let repo = Repository(id: 0, name: "test", fullName: "test/test")
        let closedIssue = Issue(id: issueId, number: 2, title: "title", body: "", state: "close", creator: user1, assignees: [user1], labels: [label1], milestone: milestone, pull: nil, repository: repo)
        
        completion(closedIssue)
    }
}

struct IssueServiceFailureStub: IssueService {
    var currentParameter: IssuesParameter = IssuesParameter.standard
    
    func getIssues(then completion: @escaping ([Issue]?) -> Void) {
        completion([])
    }
    
    func close(issueId: Int, completion: @escaping (Issue?) -> Void) {
        completion(nil)
    }
}
