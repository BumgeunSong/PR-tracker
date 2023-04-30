//
//  IssueTableCellViewModel.swift
//  PRTracker
//
//  Created by 안상희 on 2022/06/15.
//

import Foundation

final class IssueTableCellViewModel {
    var id: Int?
    let title: Observable<String?> = Observable(nil)
    let state: Observable<String?> = Observable(nil)
    let content: Observable<String?> = Observable(nil)
    let projectName: Observable<String?> = Observable(nil)
    let labelList: Observable<[LabelViewModel]?> = Observable(nil)
    let commentCount: Observable<Int?> = Observable(nil)
    
    func configureCellData(with data: Issue) {
        self.id = data.id
        self.state.value = data.state
        self.title.value = data.title
        self.content.value = data.body
        self.projectName.value = data.milestone?.title
    }
}
