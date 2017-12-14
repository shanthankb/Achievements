//
//  Group+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var categoryIDs: String?
    @NSManaged public var id: String?
    @NSManaged public var order: Int16
    @NSManaged public var categories: NSSet?

    public func sortedCategories() -> [Category]?
    {
        let unsortedCategories = categories?.allObjects as? [Category]
        let sortedCategories = unsortedCategories?.sorted(by: { (categoryOne: Category, categoryTwo : Category) -> Bool in
            return categoryOne.order < categoryTwo.order
        })
        return sortedCategories
    }
    
    override class func create(with info: [String : AnyObject], inContext: NSManagedObjectContext) -> NSManagedObject? {
        let group = ModelFactory.create(object: Constants.ObjectType.Group, with: info, in: inContext)
        return group
    }

}

// MARK: Generated accessors for categories
extension Group {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}
