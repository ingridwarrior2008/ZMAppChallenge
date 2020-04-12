//
//  PostTests.swift
//  ZMAppChallengeTests
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import XCTest
@testable import ZMAppChallenge

class PostManagmentServiceTests: XCTestCase {
    
    var networkManager: DataManagerMockNetworkProvider?
    
    func testGetPostWithNilValues() throws {
        networkManager = DataManagerMockNetworkProvider("mockNilPost")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let postServices = PostManagmentService(networkManager: networkManager)
        postServices.loadPost { (posts, error) in
            XCTAssertEqual(posts.count, 1, "Number of post should be equal to 1")
            XCTAssertEqual(posts.first?.title, "")
            XCTAssertEqual(posts.first?.body, "")
        }
    }
    
    func testGetPostWithSomeValuesNotPresent() throws {
        networkManager = DataManagerMockNetworkProvider("mockWithNoValuesPost")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let postServices = PostManagmentService(networkManager: networkManager)
        postServices.loadPost { (posts, error) in
            XCTAssertEqual(posts.count, 1, "Number of post should be equal to 1")
            XCTAssertEqual(posts.first?.title, "Title with no body present")
            XCTAssertEqual(posts.first?.body, "")
        }
    }
}
