//
//  CategoryController.swift
//  Achievements
//
//  Created by Shanthan on 11/8/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import MagicalRecord

class CategoryController: NSObject {
    
    //singleton instance helps when we are maintaining a state of the application
    //For current requirement we do not need singleton design pattern.

//    static let sharedController = CategoryController()
//    
//    private override init() {
//    }
    
    func fetchCategories(forGroup group : Group?, successBlock : @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        let ids = group?.categoryIDs

        if ids != nil {
            GETRequestHelper.fetchCategories(with: ids, successBlock: { (response : [AnyHashable : Any]?) in
                
                let context = NSManagedObjectContext.mr_context(with: NSPersistentStoreCoordinator.mr_default()!)
                context.mr_save({ (inContext : NSManagedObjectContext) in
                    if response != nil
                    {
                        let result = response![Constants.KEYs.Result] as! NSArray
//                        var categories : [Category] = []
                        let tempGroup = Group.mr_findFirst(with: NSPredicate(format:"id = %@",group!.id!), in: inContext)

                        for categoryInfo in result{
                            let categoryInfoDictionary = (categoryInfo as! [String : AnyObject])
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
                            category!.categoryDescription = categoryInfoDictionary[Constants.KEYs.Description] as? String
                            category!.icon = categoryInfoDictionary[Constants.KEYs.Icon] as? String
                            
                            let categoryAchievements = categoryInfoDictionary[Constants.KEYs.Achievements]
                            
                            let achivementIDs = ((categoryAchievements as! [Int16]).map{String(describing: $0)}).joined(separator: ",")
                            
                            //saving achievement ids as string
                            category!.achievementIDs = achivementIDs

                            tempGroup!.addToCategories(category!)
                        }
                    }
                    
                }, completion: { (state : Bool, error : Error?) in
                    successBlock(nil)
                    
                })

            }){ (message : String?,code : Int?) in
                failureBlock(message, code)
            }

        }
    }
    
    
    func category(with id : Int16?) -> Category?
    {
        let context = NSManagedObjectContext.mr_default()
        let category = Category.mr_findFirst(with: NSPredicate(format:"id = %d", id ?? 0), in: context)
        return category
    }
}
