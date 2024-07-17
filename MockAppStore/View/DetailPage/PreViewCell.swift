//
//  PreViewCell.swift
//  MockAppStore
//
//  Created by NY on 2024/6/20.
//

import UIKit

class PreViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PreViewCell"

    lazy var previewImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellUI() {
        contentView.addSubview(previewImageView)
//        contentView.addSubview(deviceLabel)
        
        NSLayoutConstraint.activate([
            previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
//            deviceLabel.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 15),
//            deviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            deviceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            deviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(_ result: String) {
        previewImageView.loadImage(result)
//        deviceLabel.text = result.supportedDevices[0]
    }
    
}
