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
                            let category = ModelFactory.create(category: categoryInfo as! [String : AnyObject], inContext: inContext)
                            tempGroup!.addToCategories(category)
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
