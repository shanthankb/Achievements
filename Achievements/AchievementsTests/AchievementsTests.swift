//
//  AchievementsTests.swift
//  AchievementsTests
//
//  Created by Shanthan on 11/24/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import XCTest
import MagicalRecord

@testable import Achievements

class AchievementsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        MagicalRecord.cleanUp()
        MagicalRecord.setupCoreDataStackWithInMemoryStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MagicalRecord.cleanUp()
        super.tearDown()
    }
    
    func testGroupCreation()
    {
        //data can be read from a file
        let groupInfo = [
            "categories" :[
                Int16(148),
                Int16(170),
                Int16(30)
            ],
            "description": "Achievements related to the Fractals of the Mists.",
            "id":"4E6A6CE7-B131-40BB-81A3-235CDBACDAA9",
            "name" : "Fractals of the Mists",
            "order" : Int16(9)
            ] as [String : AnyObject]
        
        let context = NSManagedObjectContext.mr_context(with: NSPersistentStoreCoordinator.mr_default()!)
        
        context.mr_save({ (inContext : NSManagedObjectContext) in
            let group = ModelFactory.create(group: groupInfo, inContext: inContext)
            XCTAssertNotNil(group, "Group created!")

        }) { (state : Bool, error : Error?) in
            XCTAssertTrue(state)
        }
        

        self.measure {
            // Put the code you want to measure the time of here.
        }

    }
}
