//
//  ParentEntity+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension ParentEntity: FactoryProtocol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParentEntity> {
        return NSFetchRequest<ParentEntity>(entityName: "ParentEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var entityDescription: String?

    class func create(with info: [String : AnyObject], inContext: NSManagedObjectContext) -> NSManagedObject? {
        fatalError("Must Override")
        //return ParentEntity.mr_createEntity()
    }

}
