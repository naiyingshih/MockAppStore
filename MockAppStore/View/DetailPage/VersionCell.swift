//
//  VersionCell.swift
//  MockAppStore
//
//  Created by NY on 2024/6/20.
//

import UIKit

class VersionCell: UICollectionViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    func configureCell(_ result: AppInfo) {
        versionLabel.text = "版本\(result.version)"
        descriptionLabel.text = result.releaseNotes
        dateLable.text = result.releaseDate
    }

}
