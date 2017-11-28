//
//  ModelFactory.swift
//  Achievements
//
//  Created by Shanthan on 11/28/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import MagicalRecord

class ModelFactory: NSObject {
    
    class func create(group groupInfo: [String : AnyObject], inContext : NSManagedObjectContext) -> Group
    {
        let groupInfoDictionary = groupInfo//(groupInfo as! [String : AnyObject])
        let id = groupInfoDictionary[Constants.KEYs.Id] as! String
        
        let groups = Group.mr_findAll(with: NSPredicate(format: "id = %@",id), in: inContext) as? [Group]
        
        var group : Group?
        if (groups != nil && groups!.isEmpty == false)
        {
            group = groups![0]
        }
        else
        {
            group = Group.mr_createEntity(in: inContext)
        }
        
        group!.id = id
        group!.name = groupInfoDictionary[Constants.KEYs.Name] as? String
        group!.order = groupInfoDictionary[Constants.KEYs.Order] as! Int16
        group!.entityDescription = groupInfoDictionary[Constants.KEYs.Description] as? String
        
        let groupCategories = groupInfoDictionary[Constants.KEYs.Categories]
        //saving category ids as string
        let categoryIDs = ((groupCategories as! [Int16]).map{String(describing: $0)}).joined(separator: ",")
        group!.categoryIDs = categoryIDs
        
        return group!
    }
    
    class func create(category categoryInfo :[String : AnyObject], inContext : NSManagedObjectContext ) -> Category
    {
        let categoryInfoDictionary = categoryInfo//(categoryInfo as! [String : AnyObject])
        let id = categoryInfoDictionary[Constants.KEYs.Id] as! Int16
        
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
        category!.name = categoryInfoDictionary[Constants.KEYs.Name] as? String
        category!.order = categoryInfoDictionary[Constants.KEYs.Order] as! Int16
        category!.entityDescription = categoryInfoDictionary[Constants.KEYs.Description] as? String
        category!.icon = categoryInfoDictionary[Constants.KEYs.Icon] as? String
        
        let categoryAchievements = categoryInfoDictionary[Constants.KEYs.Achievements]
        
        let achivementIDs = ((categoryAchievements as! [Int16]).map{String(describing: $0)}).joined(separator: ",")
        
        //saving achievement ids as string
        category!.achievementIDs = achivementIDs
        
        return category!
    }
    
    class func create(achievement achievementInfo :[String : AnyObject], inContext : NSManagedObjectContext ) -> Achievement
    {
        let achievementInfoDictionary = achievementInfo//(achievementInfo as! [String : AnyObject])
        let id = achievementInfoDictionary[Constants.KEYs.Id] as! Int16
        
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
        achievement!.name = achievementInfoDictionary[Constants.KEYs.Name] as? String
        achievement!.entityDescription = achievementInfoDictionary[Constants.KEYs.Description] as? String
        achievement!.icon = achievementInfoDictionary[Constants.KEYs.Icon] as? String
        achievement!.type = achievementInfoDictionary[Constants.KEYs.TypeKey] as? String
        achievement!.lockedText = achievementInfoDictionary[Constants.KEYs.LockedText] as? String
        
        return achievement!
    }
}
