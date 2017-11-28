//
//  AchievementsTests.swift
//  AchievementsTests
//
//  Created by Shanthan on 11/24/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import XCTest

@testable import Achievements

class AchievementsTests: XCTestCase {
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
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testGroupCreation()
    {
        let promise = expectation(description: "Status code: 200")

        groupController!.fetchGroups(successBlock: { (response : [AnyHashable : Any]?) in
//            print("testGroupCreation : \(String(describing: response))")
            if(response != nil)
            {
                print("PASS")
            }
            else{
                print("FAIL")
            }
            promise.fulfill()
        }) { (msg : String?, code : Int?) in
            print(msg ?? "Fail!", code ?? 0)
            promise.fulfill()
        }
        
//        var i = 0
//        while(i < 100000000) {
//           print(i)
//            i += 1
//        }
        waitForExpectations(timeout: 15) { (error : Error?) in
            
        }
        
        self.measure {
            // Put the code you want to measure the time of here.
        }

    }
    
//    func testPerformanceAPIs()
//    {
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
