//
//  Constants.swift
//  Achievements
//
//  Created by Shanthan on 11/14/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation

struct Constants {
    struct URLs {
        static let ReachabilityHostURL = "www.apple.com"
        static let BaseURL = "https://api.guildwars2.com/v2/"
        static let GroupsAPI = "achievements/groups"
        static let CatagoriesAPI = "achievements/categories"
        static let AchievementsAPI = "achievements"
    }
    
    struct KEYs {
        static let ContentType = "Content-Type"
        static let ApplicationJSON = "application/json"
        
        static let Result = "result"
        static let Id = "id"
        static let Name = "name"
        static let Description = "description"
        static let Icon = "icon"
        static let TypeKey = "type"
        static let LockedText = "lockedText"
        static let Order = "order"
        static let Achievements = "achievements"
        static let Categories = "categories"
    }
    
    enum ObjectType : String {
        case Group = "GroupObj"
        case Category = "CategoryObj"
        case Achievement = "AchievementObj"
    }
    
    struct Storyboard {
        static let Group = "Group"
        static let Category = "Category"
        static let Achievement = "Achievement"
    }
    
    struct View {
        static let TitleAndDescriptionTableViewCell = "TitleAndDescriptionTableViewCell"
        static let CategoryListViewController = "CategoryListViewController"
        static let ImageAndDetailsTableViewCell = "ImageAndDetailsTableViewCell"
        static let AchievementListViewController = "AchievementListViewController"
        static let AchievementDetailViewController = "AchievementDetailViewController"
        static let GroupListViewController = "GroupListViewController"
    }
    
    struct ScreenTitle {
        static let Groups = "Groups"
        static let Achievement = "Achievement"
    }
    
    struct NetworkError {
        static let NetworkNotReachable = "Network not reachable!"
    }
    
    struct Font {
        static let Helvetica = "Helvetica"
    }

    struct CoreData {
        static let Achievements = "Achievements"
    }
}
