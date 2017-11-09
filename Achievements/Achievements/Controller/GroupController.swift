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
typealias failureBlockType = (_ responseString : String?, _ statusCode : Int) -> Void

let urlString = "https://api.guildwars2.com/v2/"

class GroupController: NSObject {
    
    static let sharedController = GroupController()
    
    private override init() {
    }
    
    func fetchGroups(successBlock : @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        GETRequestHelper.fetchGroups(successBlock: { (response : [AnyHashable : Any]?) in
            
            let context = NSManagedObjectContext.mr_context(with: NSPersistentStoreCoordinator.mr_default()!)
            context.mr_save({ (inContext : NSManagedObjectContext) in
                
                if response != nil
                {
                    let result = response!["result"] as! NSArray
                    for groupInfo in result{
                        let groupInfoDictionary = (groupInfo as! [String : AnyObject])
                        let id = groupInfoDictionary["id"] as! String
                        
                        let groups = Group.mr_findAll(with: NSPredicate(format: "id = %@",id), in: inContext) as? [Group]
                        
                        var group : Group?
                        if (groups != nil && groups!.count > 0)
                        {
                            group = groups![0]
                        }
                        else
                        {
                            group = Group.mr_createEntity(in: inContext)
                        }
                        
                        group!.id = id
                        group!.name = groupInfoDictionary["name"] as? String
                        group!.order = groupInfoDictionary["order"] as! Int16
                        group!.groupDescription = groupInfoDictionary["description"] as? String
                        
                        let groupCategories = groupInfoDictionary["categories"]
                        //saving category ids as string
                        let categoryIDs = ((groupCategories as! [Int16]).map{String(describing: $0)}).joined(separator: ",")
                        group!.categoryIDs = categoryIDs
                    }
                }
            }, completion: { (state : Bool, error : Error?) in
                successBlock(nil)

            })
            
        }) { (message : String?,code : Int) in
            failureBlock(message, code)
        }
    }
    
    func groups() -> [Group]?
    {
        let context = NSManagedObjectContext.mr_default()
        let groups = Group.mr_findAll(in: context) as? [Group]
        return groups
    }
    
    func group(with id : String?) -> Group?
    {
        let context = NSManagedObjectContext.mr_default()
        let group = Group.mr_findFirst(with: NSPredicate(format:"id = %@", id ?? ""), in: context)
        return group
    }

}
