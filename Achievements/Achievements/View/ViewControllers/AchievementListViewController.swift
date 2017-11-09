//
//  AchievementListViewController.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import UIKit

class AchievementListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var listView: UITableView!
    var achievementList : [Achievement]?
    
    var parentCategory : Category? {
        didSet{
            AchievementController.sharedController.fetchAchievements(forCategory: parentCategory, successBlock: { (response) in
                self.reloadView()
            }) { (message : String?, code : Int) in
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = parentCategory?.name
        
        //we can use googleicon.ttf font for image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left.png"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func backButtonClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadView()
    {
        let category = CategoryController.sharedController.category(with: parentCategory?.id)
        achievementList = category?.achievements?.allObjects as? [Achievement]
        listView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : ImageAndDetailsTableViewCell!
        cell  = listView.dequeueReusableCell(withIdentifier: "ImageAndDetailsTableViewCell") as? ImageAndDetailsTableViewCell
        cell.titleLabel.text = achievementList![indexPath.row].name
        cell.descriptionLabel.text = achievementList![indexPath.row].achievementDescription
        let imageURL = URL(string: achievementList![indexPath.row].icon ?? "")
        
        cell.iconView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "PlaceHolderImage.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AchievementDetailViewController") as! AchievementDetailViewController
        viewController.achievement = achievementList![indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}
