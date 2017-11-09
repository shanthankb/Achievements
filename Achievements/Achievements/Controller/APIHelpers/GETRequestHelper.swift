//
//  GETRequestHelper.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import Alamofire

let groupsAPI = "achievements/groups"
let catagoriesAPI = "achievements/categories"
let achievementsAPI = "achievements"
let contentType = "Content-Type"
let applicationJSON = "application/json"

class GETRequestHelper: NSObject {
    
    class func fetchGroups(successBlock: @escaping successBlockType, failureBlock : @escaping failureBlockType)
    {
        Alamofire.request(urlString+groupsAPI)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    let json = response.result.value
                    if(json != nil)
                    {
                        GETRequestHelper.fetchDetailsFor(groups: json as! [String], successBlock : successBlock, failureBlock: failureBlock)
                    }
                    break
                case .failure:
                    failureBlock(nil, nil)
                    break
                    
                }
        }
    }
    
    class func fetchDetailsFor(groups : [String], successBlock: @escaping successBlockType, failureBlock : failureBlockType)
    {
        let string = groups.joined(separator: ",")

        let parameters : Parameters = ["ids" : string]
        
        Alamofire.request(urlString+groupsAPI, method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: [contentType : applicationJSON])
            .validate()
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
        let parameters : Parameters = ["ids" : ids ?? ""]
        
        Alamofire.request(urlString+catagoriesAPI, method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: [contentType : applicationJSON])
            .validate()
            .responseJSON { (response) in
                var result:[AnyHashable:Any]? = nil
                if let json = response.result.value
                {
                    print(json)
                    result = ["result" : json]
                }
                
                successBlock(result)
        }
    }

    class func fetchAchievements(with ids : String?, successBlock: @escaping successBlockType, failureBlock : failureBlockType)
    {
        let parameters : Parameters = ["ids" : ids ?? ""]
        
        Alamofire.request(urlString+achievementsAPI, method: .get, parameters: parameters, encoding: URLEncoding.methodDependent, headers: [contentType : applicationJSON])
            .validate()
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
