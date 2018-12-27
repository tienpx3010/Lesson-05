//
//  CustomTableViewCell.swift
//  Lesson-05
//
//  Created by pham.xuan.tien on 12/17/18.
//  Copyright © 2018 pham.xuan.tien. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
