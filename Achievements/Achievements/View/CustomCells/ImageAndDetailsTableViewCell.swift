//
//  ImageAndDetailsTableViewCell.swift
//  Achievements
//
//  Created by Shanthan on 11/9/17.
//  Copyright © 2017 Shanthan. All rights reserved.
//

import Foundation
import UIKit

class ImageAndDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
