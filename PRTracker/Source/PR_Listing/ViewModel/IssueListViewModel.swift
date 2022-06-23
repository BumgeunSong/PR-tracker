//
//  PullListViewModel.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/13.
//

import Foundation

final class IssueListViewModel {
    private let mockDataService = MockDataService()
    
    // 지금 이거는 의존하고 이쓴거. IssueListViewModel이 IssueMaanger에게 의존하고잇어.
    // 의존이 아닌 고립 시키도록. 강한 결합 노노
    private let issueManager = IssueManager() // IssueListViewModel 생성시, issueManager랑 비슷한 역할을 하는. 걸로 갈아끼우기 위한 게 필요.
    // 뷰모델에연결되어있는 객체를 갈아끼울 수 있도록. init(manager: ISsueemanager()) 조립식으로 바꿔야한다. 지금은 세트로 붙어있어. 세트상품.. 의존이잇으면 issueMaager 내부코드도 다 테스트하게되어버림. 테스트용 객체로 갈아끼워줘야함. 항상 옳은 것만 리턴할 수 있도록..
    
    // IssueManager는 항상 제대로 동작을 하는 Stub으로 만들어놓기. (이슈 오기)
    // IssueManager가 항상 실패하는 Stub (이슈 안오기)
    
    // 1. IssueListViewModel이
    // 2.
    
    // 추상화: 호환성 만들어주기
    // protocol earphone -> 이어폰 프로토콜 갖는 에어팟. 버즈. 줄이어폰. 헤드폰.
    // 이어폰에 호출하면, 버즈가 들어오든 에어팟이 들어오든 음악 플레이 가능.
    // 스마트폰에서 노래 듣기 위해 이어폰에 의존.
    // 에어팟만 받아서 실행시키는 코드 호출하면. 에어팟만 돼
    //
    private let issueService: IssueService
    
    // 프로토콜 이름으로 넣어줘야야해 -> 추상타입에 의존.
    init(issueService: IssueService = IssueManager()) { // default 타입. 테스트할때만 갈아ㄲㅣ우니까
        // IssueManagerStub을 넣고 싶은데. 이것만 해놓으면 성공/실패 stub을 못하고. IssueManager
        self.issueService = issueService
    }
    
    var issueViewModels: Observable<[IssueTableCellViewModel]?> = Observable(nil)

    var numberOfViewModels: Int {
        return issueViewModels.value?.count ?? 0
    }
    
    func searchBarTextDidChange(with text: String) {
        // TODO: SearchBarText가 바뀌면 호출되는 부분 구현
    }
    
    func requestData() {
        issueService.getIssues { issues in
            guard let issues = issues else {
                return
            }
            
            self.issueViewModels.value = self.convertModelToViewModel(issues)
        }
        // 리턴을 안해... 
    }
    
    func requestMockData() {
        mockDataService.getMockIssues { issues in
            guard let issues = issues else {
                return
            }
            
            self.issueViewModels.value = convertModelToViewModel(issues)
        }
    }
    
    private func convertModelToViewModel(_ list: [Issue]) -> [IssueTableCellViewModel] {
        let tableCellViewModelList = list.map { pull -> IssueTableCellViewModel in
            let tableCellViewModel = IssueTableCellViewModel()
            tableCellViewModel.configureCellData(with: pull)
            return tableCellViewModel
        }
        return tableCellViewModelList
    }
    
    func getCellViewModel(index: Int) -> IssueTableCellViewModel? {
        return issueViewModels.value?[index]
    }
}
