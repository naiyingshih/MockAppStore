//
//  AppSectionFooterView.swift
//  MockAppStore
//
//  Created by NY on 2024/7/16.
//

import UIKit

class AppSectionFooterView: UICollectionReusableView {
    static let reuseIdentifier = "AppSectionFooterView"
    
    lazy var deviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellUI() {
        addSubview(deviceLabel)
        
        NSLayoutConstraint.activate([
            deviceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            deviceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            deviceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configureCell(_ result: AppInfo) {
        deviceLabel.text = result.supportedDevices[0]
    }
    
}
