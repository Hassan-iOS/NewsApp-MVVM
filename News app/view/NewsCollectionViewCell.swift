//
//  NewsCollectionViewCell.swift
//  News app
//
//  Created by Hassan Mostafa on 7/30/19.
//  Copyright © 2019 Hassan Mostafa . All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
