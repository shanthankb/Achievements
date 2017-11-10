//
//  GroupListViewController.swift
//  Achievements
//
//  Created by Shanthan on 11/7/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import UIKit

class GroupListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerProtocol
{
    @IBOutlet weak var listView: UITableView!
    var groupList : [Group]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Groups"
        self.navigationItem.leftBarButtonItem?.title = ""
    }
    
    func viewControllerWillLoad() {
        //request controller for group data
//        GroupController.sharedController.fetchGroups(successBlock: { (response) in
        GroupController().fetchGroups(successBlock: { (response) in
            //update view
            self.reloadView()
        }) { (message : String?, code : Int?) in
            self.reloadView()
        }
    }

    func reloadView()
    {
//        groupList = GroupController.sharedController.groups()
        groupList = GroupController().groups()
        self.listView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : TitleAndDescriptionTableViewCell!
        cell  = listView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionTableViewCell") as? TitleAndDescriptionTableViewCell
        cell.titleLabel.text = groupList![indexPath.row].name
        cell.descriptionLabel.text = groupList![indexPath.row].groupDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CategoryListViewController") as! CategoryListViewController
        viewController.parentGroup = groupList![indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)

    }
}
