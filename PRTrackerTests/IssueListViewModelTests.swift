//
//  IssueListViewModelTests.swift
//  PRTrackerTests
//
//  Created by 안상희 on 2022/06/23.
//

import XCTest

class IssueListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_viewModel_should_get_data_when_issueManager_get_issues() {
        // given - 뷰모델에 issueManager가 있을 때
        let sut = IssueListViewModel(issueService: IssueServiceSuccessStub())

        // when - 이슈 목록을 요청하면
        sut.requestData()

        // then - 이슈 목록 (데이터)을 가져왔는지 확인.
        // 데이터 갯수가 2개라면 테스트 성공
        XCTAssertEqual(sut.issueViewModels.value?.count, 2)
        XCTAssertEqual(sut.issueViewModels.value?[0].title.value, "PR 제목입니당")
        XCTAssertEqual(sut.issueViewModels.value?[0].content.value, "작업 내용은 다음과 같습니다,,\n클릭해서 봐주세요..")
        XCTAssertEqual(sut.issueViewModels.value?[1].title.value, "PR 제목입니당2")
        XCTAssertEqual(sut.issueViewModels.value?[1].content.value, "작업 내용은 다음과 같습니다,,\n클릭해서 봐주세욤")
    }
    
    func test_viewModel_should_get_no_data_when_issueManager_get_zero_issues() {
        // given - 뷰모델에 issueManager가 있을 때
        let sut = IssueListViewModel(issueService: IssueServiceFailureStub())

        // when - 이슈 목록을 요청하면
        sut.requestData()

        // then - 이슈 목록 (데이터)을 가져왔는지 확인.
        // 데이터 갯수가 0개라면 테스트 성공
        XCTAssertEqual(sut.issueViewModels.value?.count, 0)
    }
}
