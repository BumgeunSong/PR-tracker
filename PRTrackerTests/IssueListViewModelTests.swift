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
        // System Under Test
        sut.requestData()
        
        // then - 이슈 목록 (데이터)을 가져왔는지 확인.
        // 데이터 갯수가 1개 이상이면 trueXXX
        // 데이터 갯수로 할게 아니라 데이터 내용
        // 테스트객체에서 뷰모델에?
        XCTAssertEqual(sut.issueViewModels.value?.count, 2)
        
        // 주요한 속성 . . ?...
    }
    
    // 두번째 XCTAssertNil
    
    // 세번째
    // 모델을 뷰모델로 제대로 바꿨는지 테스트. 중요한것들. 뷰모델 내의 속성
//    func test_
}

// 1. IssueViewModel이 추상타입에 의존하도록 해서 갈아끼우기 가능하게하기
// 2. 갈아끼는 Stub 객체 만들기 (추상타입을 채택하는 Stub 객체)
// 3. 그 Stub 객체에서 가짜 데이터 리턴하도록 하기 (mock~~)
// 4. stub 객체 넣어서 테스트할 대상 만들기 (뷰모델이 stub 사용해서 요청 보내게 됨.) 결합 끊음. 분리.
// -> Mocking!!! 우리가 원하는 대상만 테스트하기 위해서.

// + 비동기테스트..? 나즁에..
