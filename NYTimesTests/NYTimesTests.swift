//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by MAC on 12/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//



import XCTest
@testable import NYTimes
import RxSwift

class NYTimesTests: XCTestCase {
    var articalMock = ArticalMockRepo()
   lazy var viewModel = ArticalesViewModel()
    var disposeBag = DisposeBag()

    override func setUp() {
        articalMock.getMockedAricalList { (articals) in
            self.viewModel.isSuccess.onNext(articals)
        }
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetAritcalListOnSucess(){
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (data) in
                XCTAssertEqual(data.count, 1 )
            }).disposed(by: disposeBag)
        }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
