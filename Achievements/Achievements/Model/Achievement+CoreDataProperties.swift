//
//  Achievement+CoreDataProperties.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData


extension Achievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievement> {
        return NSFetchRequest<Achievement>(entityName: "Achievement")
    }

    @NSManaged public var flags: String?
    @NSManaged public var icon: String?
    @NSManaged public var lockedText: String?
    @NSManaged public var pointCap: Int16
    @NSManaged public var prerequisites: String?
    @NSManaged public var requirement: String?
    @NSManaged public var type: String?
    @NSManaged public var id: Int16
    @NSManaged public var bits: NSSet?
    @NSManaged public var category: Category?
    @NSManaged public var rewards: NSSet?
    @NSManaged public var tiers: NSSet?

    override class func create(with info: [String : AnyObject], inContext: NSManagedObjectContext) -> NSManagedObject? {
        let id = info[Constants.KEYs.Id] as! Int16
        
        let storedAchievements = Achievement.mr_findAll(with: NSPredicate(format: "id = %d",id), in: inContext) as? [Achievement]
        
        var achievement : Achievement?
        if (storedAchievements != nil && storedAchievements!.isEmpty == false)
        {
            achievement = storedAchievements![0]
        }
        else
        {
            achievement = Achievement.mr_createEntity(in: inContext)
        }
        
        achievement!.id = id
        achievement!.name = info[Constants.KEYs.Name] as? String
        achievement!.entityDescription = info[Constants.KEYs.Description] as? String
        achievement!.icon = info[Constants.KEYs.Icon] as? String
        achievement!.type = info[Constants.KEYs.TypeKey] as? String
        achievement!.lockedText = info[Constants.KEYs.LockedText] as? String
        
        return achievement!
    }
}

// MARK: Generated accessors for bits
extension Achievement {

    @objc(addBitsObject:)
    @NSManaged public func addToBits(_ value: Bit)

    @objc(removeBitsObject:)
    @NSManaged public func removeFromBits(_ value: Bit)

    @objc(addBits:)
    @NSManaged public func addToBits(_ values: NSSet)

    @objc(removeBits:)
    @NSManaged public func removeFromBits(_ values: NSSet)

}

// MARK: Generated accessors for rewards
extension Achievement {

    @objc(addRewardsObject:)
    @NSManaged public func addToRewards(_ value: Reward)

    @objc(removeRewardsObject:)
    @NSManaged public func removeFromRewards(_ value: Reward)

    @objc(addRewards:)
    @NSManaged public func addToRewards(_ values: NSSet)

    @objc(removeRewards:)
    @NSManaged public func removeFromRewards(_ values: NSSet)

}

// MARK: Generated accessors for tiers
extension Achievement {

    @objc(addTiersObject:)
    @NSManaged public func addToTiers(_ value: Tier)

    @objc(removeTiersObject:)
    @NSManaged public func removeFromTiers(_ value: Tier)

    @objc(addTiers:)
    @NSManaged public func addToTiers(_ values: NSSet)

    @objc(removeTiers:)
    @NSManaged public func removeFromTiers(_ values: NSSet)

}
