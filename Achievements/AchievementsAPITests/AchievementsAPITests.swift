//
//  AchievementsAPITests.swift
//  AchievementsAPITests
//
//  Created by Shanthan on 11/28/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import XCTest

@testable import Achievements

class AchievementsAPITests: XCTestCase {
    var groupController : GroupController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        groupController = GroupController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        groupController = nil
        super.tearDown()
    }
    
    func testGroupCreation()
    {
        let promise = expectation(description: "Status code: 200")
        
        groupController!.fetchGroups(successBlock: { (response : [AnyHashable : Any]?) in
            
            XCTAssertNotNil(response, "Group objects created!")
            promise.fulfill()
        }) { (msg : String?, code : Int?) in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 15) { (error : Error?) in
        }
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
        
    }
}
