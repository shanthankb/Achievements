//
//  Reward+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Reward {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reward> {
        return NSFetchRequest<Reward>(entityName: "Reward")
    }

    @NSManaged public var count: Int16
    @NSManaged public var id: Int16
    @NSManaged public var region: String?
    @NSManaged public var type: String?
    @NSManaged public var achievement: Achievement?

}
