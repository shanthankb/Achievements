//
//  ParentEntity+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension ParentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParentEntity> {
        return NSFetchRequest<ParentEntity>(entityName: "ParentEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var entityDescription: String?

}
