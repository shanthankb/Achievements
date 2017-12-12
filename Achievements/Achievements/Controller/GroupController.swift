//
//  GroupController.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import MagicalRecord

typealias successBlockType = (_ response: [AnyHashable : Any]?) -> Void
typealias failureBlockType = (_ responseString : String?, _ statusCode : Int?) -> Void


class GroupController: NSObject {
    
    //singleton instance helps when we are maintaining a state of the application
    //For current requirement we do not need singleton design pattern. 
    
//    static let sharedController = GroupController()
//    
//    private override init() {
//    }
    
    func fetchGroups(successBlock : @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        GETRequestHelper.fetchGroups(successBlock: { (response : [AnyHashable : Any]?) in
            
            let context = NSManagedObjectContext.mr_context(with: NSPersistentStoreCoordinator.mr_default()!)
            context.mr_save({ (inContext : NSManagedObjectContext) in
                
                if response != nil
                {
                    let result = response![Constants.KEYs.Result] as! NSArray
                    for groupInfo in result{

                        _ = ModelFactory.create(group: groupInfo as! [String : AnyObject], inContext: inContext)

                    }
                }
            }, completion: { (state : Bool, error : Error?) in
                successBlock(response)

            })
            
        }) { (message : String?,code : Int?) in
            failureBlock(message, code)
        }
    }
        
    func groups() -> [Group]?
    {
        let context = NSManagedObjectContext.mr_default()
        let groups = Group.mr_findAll(in: context) as? [Group]
        let sortedGroups = groups?.sorted(by: { (groupOne: Group, groupTwo:Group) -> Bool in
            return groupOne.order < groupTwo.order
        })
        return sortedGroups
    }
    
    func group(with id : String?) -> Group?
    {
        let context = NSManagedObjectContext.mr_default()
        let group = Group.mr_findFirst(with: NSPredicate(format:"id = %@", id ?? ""), in: context)
        return group
    }

}
