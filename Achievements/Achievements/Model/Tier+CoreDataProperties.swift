//
//  Tier+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Tier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tier> {
        return NSFetchRequest<Tier>(entityName: "Tier")
    }

    @NSManaged public var count: Int16
    @NSManaged public var points: Int16
    @NSManaged public var achievement: Achievement?

    class func create(with info: [String : AnyObject], inContext: NSManagedObjectContext) -> NSManagedObject? {
        return nil
    }

}
