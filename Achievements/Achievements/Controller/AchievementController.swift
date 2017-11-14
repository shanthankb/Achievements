//
//  AchievementController.swift
//  Achievements
//
//  Created by Shanthan on 11/9/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation

import MagicalRecord

class AchievementController: NSObject {
    
    //singleton instance helps when we are maintaining a state of the application
    //For current requirement we do not need singleton design pattern.

//    static let sharedController = AchievementController()
//    
//    private override init() {
//    }
    
    func fetchAchievements(forCategory category : Category?, successBlock : @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        let ids = category?.achievementIDs 
        
        if ids != nil {
            GETRequestHelper.fetchAchievements(with: ids, successBlock: { (response : [AnyHashable : Any]?) in
                
                let context = NSManagedObjectContext.mr_context(with: NSPersistentStoreCoordinator.mr_default()!)
                context.mr_save({ (inContext : NSManagedObjectContext) in
                    
                    if response != nil
                    {
                        let result = response![Constants.KEYs.Result] as! NSArray
//                        var achievements : [Achievement] = []
                        
                        let tempCategory = Category.mr_findFirst(with: NSPredicate(format:"id = %d",category!.id), in: inContext)

                        for achievementInfo in result{
                            let achievementInfoDictionary = (achievementInfo as! [String : AnyObject])
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
                            achievement!.achievementDescription = achievementInfoDictionary[Constants.KEYs.Description] as? String
                            achievement!.icon = achievementInfoDictionary[Constants.KEYs.Icon] as? String
                            achievement!.type = achievementInfoDictionary[Constants.KEYs.TypeKey] as? String
                            achievement!.lockedText = achievementInfoDictionary[Constants.KEYs.LockedText] as? String
                            
                            //Tier, Bit and Reward objects can be created here for Achievements
                            
                            tempCategory!.addToAchievements(achievement!)
                        }
                    }
                    
                }, completion: { (state : Bool, error : Error?) in
                    successBlock(nil)
                    
                })
                
            }) { (message : String?,code : Int?) in
                failureBlock(message, code)
            }
        }
    }
}
