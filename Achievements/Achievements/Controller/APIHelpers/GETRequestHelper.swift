//
//  GETRequestHelper.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import Alamofire

class GETRequestHelper: NSObject {
    
    class func fetchGroups(successBlock: @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        Alamofire.request(urlString+"achievements/groups/")
            .responseJSON { response in
                
            let json = response.result.value
                if(json != nil)
                {
                    //print(json as! [String])
                    GETRequestHelper.fetchDetailsFor(groups: json as! [String], successBlock : successBlock, failureBlock: failureBlock)
                }
        }
        
        //uest(urlString+"achievements/groups/", method: .get, parameters: nil, encoding: .default, headers: nil)
    }
    
    class func fetchDetailsFor(groups : [String], successBlock: @escaping successBlockType, failureBlock : failureBlockType)
    {
        let string = groups.joined(separator: ",")

        let parameters : Parameters = ["ids" : string]
        
        Alamofire.request(urlString+"achievements/groups", method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: ["Content-Type" : "application/json"])
            .responseJSON { (response) in
                var result:[AnyHashable:Any]? = nil
                if let json = response.result.value
                {
                    //print(json)
                     result = ["result" : json]
                }
                
                successBlock(result)
        }
    }
    
    class func fetchCategories(with ids : String?, successBlock: @escaping successBlockType, failureBlock : failureBlockType)
    {
//        let string = (ids.map{String($0)}).joined(separator: ",")
        let parameters : Parameters = ["ids" : ids ?? ""]
        
        Alamofire.request(urlString+"achievements/categories", method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: ["Content-Type" : "application/json"])
            .responseJSON { (response) in
                var result:[AnyHashable:Any]? = nil
                if let json = response.result.value
                {
                    //print(json)
                    result = ["result" : json]
                }
                
                successBlock(result)
        }
    }

    class func fetchAchievements(with ids : String?, successBlock: @escaping successBlockType, failureBlock : failureBlockType)
    {
//        let string = (ids.map{String($0)}).joined(separator: ",")
        let parameters : Parameters = ["ids" : ids ?? ""]
        
        Alamofire.request(urlString+"achievements", method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: ["Content-Type" : "application/json"])
            .responseJSON { (response) in
                var result:[AnyHashable:Any]? = nil
                if let json = response.result.value
                {
                    //print(json)
                    result = ["result" : json]
                }
                
                successBlock(result)
        }
    }

}
