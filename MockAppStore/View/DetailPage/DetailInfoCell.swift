//
//  DetailInfoCell.swift
//  MockAppStore
//
//  Created by NY on 2024/6/20.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    func configureCell(_ model: DetailModel) {
        topicLabel.text = model.topic
        contentLabel.text = model.content
        bottomLabel.text = model.detail
    }

}
