//
//  ParentEntity+CoreDataClass.swift
//  
//
//  Created by Shanthan on 11/16/17.
//
//

import Foundation
import CoreData

protocol FactoryProtocol {
    static func create(with info: [String : AnyObject], inContext : NSManagedObjectContext) -> NSManagedObject?
}

public class ParentEntity: NSManagedObject {

    func method(val : Int)
    {
        
    }
}
