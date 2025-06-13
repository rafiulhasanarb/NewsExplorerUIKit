//
//  NewsServiceTests.swift
//  NewsExplorerUIKitTests
//
//  Created by Rafiul Hasan on 6/13/25.
//

import XCTest
@testable import NewsExplorerUIKit

final class NewsServiceTests: XCTestCase {

    var sut: NewsService!

    override func setUp() {
        super.setUp()
        sut = NewsService()
    }
    
    func testFetchArticles_success() {
        sut.fetchArticles() { (result) in
            switch result {
            case .success(let articles):
                XCTAssertFalse(articles.isEmpty, "Articles array should not be empty")
            case .failure(let error):
                XCTFail("Expected success, got failure with \(error)")
            }
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
