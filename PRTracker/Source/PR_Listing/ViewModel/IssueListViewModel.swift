//
//  PullListViewModel.swift
//  PRTracker
//
//  Created by Bumgeun Song on 2022/06/13.
//

import Foundation

final class IssueListViewModel {
    private var issueService: IssueService
    
    var issueViewModels: Observable<[IssueTableCellViewModel]?> = Observable(nil)

    var numberOfViewModels: Int {
        return issueViewModels.value?.count ?? 0
    }
    
    init(issueService: IssueService = IssueManager()) {
        self.issueService = issueService
    }
    
    func searchBarTextDidChange(with text: String) {
        // TODO: SearchBarText가 바뀌면 호출되는 부분 구현
    }
    
    
    func requestData() {
        issueService.getIssues { issues in
            guard let issues = issues else {
                return
            }
            self.issueViewModels.value = self.convertToViewModel(issues)
        }
    }
    
    private func convertToViewModel(_ list: [Issue]) -> [IssueTableCellViewModel] {
        let tableCellViewModelList = list.map { issue -> IssueTableCellViewModel in
            return convertToViewModel(issue)
        }
        return tableCellViewModelList
    }
    
    private func convertToViewModel(_ issue: Issue) -> IssueTableCellViewModel {
        let tableCellViewModel = IssueTableCellViewModel()
        tableCellViewModel.configureCellData(with: issue)
        return tableCellViewModel
    }
    
    func getCellViewModel(index: Int) -> IssueTableCellViewModel? {
        return issueViewModels.value?[index]
    }
    
    func close(at index: Int, completion: @escaping (Bool) -> Void) {
        guard let issueId = issueViewModels.value?[index].id else {
            return completion(false)
        }
        
        issueService.close(issueId: issueId) { issue in
            guard let issue = issue else { return completion(false) }
            let cellVM = self.convertToViewModel(issue)
            
            self.issueViewModels.value?[index] = cellVM
            completion(true)
        }
    }
}
