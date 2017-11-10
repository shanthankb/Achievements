//
//  CategoryListViewController.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CategoryListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerProtocol
{
    @IBOutlet weak var listView: UITableView!
    var categoryList : [Category]?
    
    var parentGroup : Group? {
        didSet{
            //request controller for categories
//            CategoryController.sharedController.fetchCategories(forGroup: parentGroup, successBlock: { (response) in
            
            CategoryController().fetchCategories(forGroup: parentGroup, successBlock: { (response) in
                self.reloadView()
            }) { (message : String?, code : Int?) in
                self.reloadView()
        }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = parentGroup?.name
        
        //we can use googleicon.ttf font for image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left.png"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func backButtonClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }

    func viewControllerWillLoad() {
    }
    
    func reloadView()
    {
//        let group = GroupController.sharedController.group(with: parentGroup?.id)
        let group = GroupController().group(with: parentGroup?.id)

        self.categoryList = group?.sortedCategories()
        self.listView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : ImageAndDetailsTableViewCell!
        cell  = listView.dequeueReusableCell(withIdentifier: "ImageAndDetailsTableViewCell") as? ImageAndDetailsTableViewCell
        
        cell.titleLabel.text = categoryList![indexPath.row].name
        cell.descriptionLabel.text = categoryList![indexPath.row].categoryDescription
        let imageURL = URL(string: categoryList![indexPath.row].icon ?? "")
        cell.iconView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "PlaceHolderImage.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Achievement", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AchievementListViewController") as! AchievementListViewController
        viewController.parentCategory = categoryList![indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}
