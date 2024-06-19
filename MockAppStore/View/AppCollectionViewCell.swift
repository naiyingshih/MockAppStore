//
//  AppCollectionViewCell.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var classifyLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        appIconImageView.layer.cornerRadius = 10
        appIconImageView.layer.borderWidth = 1
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        appIconImageView.contentMode = .scaleAspectFill
    }
    
    func configureCell(_ result: AppInfo) {
        appNameLabel.text = result.trackName
        classifyLabel.text = result.primaryGenreName
        appIconImageView.loadImage(result.artworkUrl100)
    }

}
