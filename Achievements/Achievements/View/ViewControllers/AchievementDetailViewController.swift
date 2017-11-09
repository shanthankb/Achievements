//
//  AchievementDetailViewController.swift
//  Achievements
//
//  Created by Shanthan on 11/9/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import UIKit

class AchievementDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    var achievement : Achievement?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Achievement"//achievement?.name
        self.nameLabel.text = achievement?.name
        self.typeLabel.text = achievement?.type
        self.descriptionView.text = achievement?.achievementDescription
        
        let imageURL = URL(string: achievement?.icon ?? "")
        
        self.pictureView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "PlaceHolderImage.png"))

    }
}
