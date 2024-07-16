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
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    lazy var deviceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .lightGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    func setupCellUI() {
        addSubview(previewImageView)
//        addSubview(deviceLabel)
        
        NSLayoutConstraint.activate([
//            
            previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            previewImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
//            previewImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            previewImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
//            deviceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
//            deviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            deviceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            deviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ result: AppInfo) {
        for result in result.screenshotUrls {
            previewImageView.loadImage(result)
        }

//        deviceLabel.text = result.supportedDevices[0]
    }
    
}
