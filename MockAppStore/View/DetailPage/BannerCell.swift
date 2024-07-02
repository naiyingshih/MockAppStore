//
//  BannerCell.swift
//  MockAppStore
//
//  Created by NY on 2024/6/20.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appClassifyLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ result: AppInfo) {
        appIconImageView.loadImage(result.artworkUrl512)
        appNameLabel.text = result.trackName
        appClassifyLabel.text = result.primaryGenreName
    }

}
