//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var achievementIDs: String?
    @NSManaged public var icon: String?
    @NSManaged public var order: Int16
    @NSManaged public var id: Int16
    @NSManaged public var achievements: NSSet?
    @NSManaged public var group: Group?

    override class func create(with info: [String : AnyObject], inContext: NSManagedObjectContext) -> NSManagedObject? {
        let id = info[Constants.KEYs.Id] as! Int16
        
        let storedCategories = Category.mr_findAll(with: NSPredicate(format: "id = %d",id), in: inContext) as? [Category]
        
        var category : Category?
        if (storedCategories != nil && storedCategories!.isEmpty == false)
        {
            category = storedCategories![0]
        }
        else
        {
            category = Category.mr_createEntity(in: inContext)
        }
        
        category!.id = id
        category!.name = info[Constants.KEYs.Name] as? String
        category!.order = info[Constants.KEYs.Order] as! Int16
        category!.entityDescription = info[Constants.KEYs.Description] as? String
        category!.icon = info[Constants.KEYs.Icon] as? String
        
        let categoryAchievements = info[Constants.KEYs.Achievements]
        
        let achivementIDs = ((categoryAchievements as! [Int16]).map{String(describing: $0)}).joined(separator: ",")
        
        //saving achievement ids as string
        category!.achievementIDs = achivementIDs
        
        return category!
    }
}

// MARK: Generated accessors for achievements
extension Category {

    @objc(addAchievementsObject:)
    @NSManaged public func addToAchievements(_ value: Achievement)

    @objc(removeAchievementsObject:)
    @NSManaged public func removeFromAchievements(_ value: Achievement)

    @objc(addAchievements:)
    @NSManaged public func addToAchievements(_ values: NSSet)

    @objc(removeAchievements:)
    @NSManaged public func removeFromAchievements(_ values: NSSet)

}
