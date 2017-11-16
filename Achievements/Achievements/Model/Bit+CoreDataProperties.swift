//
//  Bit+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Bit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bit> {
        return NSFetchRequest<Bit>(entityName: "Bit")
    }

    @NSManaged public var id: Int16
    @NSManaged public var text: String?
    @NSManaged public var type: String?
    @NSManaged public var achievement: Achievement?

}
