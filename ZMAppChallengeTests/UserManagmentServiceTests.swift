//
//  UserManagmentServiceTests.swift
//  ZMAppChallengeTests
//
//  Created by Cris on 10/04/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import XCTest
@testable import ZMAppChallenge

class UserManagmentServiceTests: XCTestCase {
    
    var networkManager: DataManagerMockNetworkProvider?
    
    func testGetUserWithSomeValuesNotPresent() throws {
        networkManager = DataManagerMockNetworkProvider("mockUserWithNoValues")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let userServices = UserManagmentService(networkManager: networkManager)
        userServices.loadUser(with: 1) { (user, error) in
            XCTAssertEqual(user?.email, "")
            XCTAssertEqual(user?.name, "")
        }
    }
    
    func testGetUserInfo() throws {
        networkManager = DataManagerMockNetworkProvider("mockUser")
        guard let networkManager = networkManager else {
            XCTAssertThrowsError("networkManager it's nil")
            return
        }
        
        let userServices = UserManagmentService(networkManager: networkManager)
        userServices.loadUser(with: 1) { (user, error) in
            XCTAssertEqual(user?.email, "Sincere@april.biz")
            XCTAssertEqual(user?.name, "Leanne Graham")
            XCTAssertEqual(user?.phone, "1-770-736-8031 x56442")
        }
    }
}
