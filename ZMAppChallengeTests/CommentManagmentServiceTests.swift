//
//  CommentManagmentServiceTests.swift
//  ZMAppChallengeTests
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import XCTest
@testable import ZMAppChallenge

class CommentManagmentServiceTests: XCTestCase {
    
    var networkManager: DataManagerMockNetworkProvider?
    
    func testCommentsWithSomeValuesNotPresent() throws {
        networkManager = DataManagerMockNetworkProvider("mockCommentsNotValues")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let commentsServices = CommentManagmentService(networkManager: networkManager)
        commentsServices.loadComments(with: 1) { (comments, error) in
            XCTAssertEqual(comments.count, 1, "Number of comments should be equal to 1")
            XCTAssertEqual(comments.first?.body, "")
            XCTAssertEqual(comments.first?.email, "")
            XCTAssertEqual(comments.first?.name, "")
        }
    }
    
    func testParsingCommentsResponse() throws {
        networkManager = DataManagerMockNetworkProvider("mockComments")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let commentsServices = CommentManagmentService(networkManager: networkManager)
        commentsServices.loadComments(with: 1) { (comments, error ) in
            XCTAssertEqual(comments.count, 5, "Number of comments should be equal to 5")
            XCTAssertEqual(comments.first?.name, "id labore ex et quam laborum")
            XCTAssertEqual(comments.first?.email, "Eliseo@gardner.biz")
            XCTAssertEqual(comments.first?.body, "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
        }
    }
}
