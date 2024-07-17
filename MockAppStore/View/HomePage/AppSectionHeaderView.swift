//
//  AppSectionHeaderView.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import UIKit

class AppSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "AppSectionHeaderView"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .tintColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(versionLabel)
        
        addTopBorder(color: .lightGray, width: 1)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            versionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            versionLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
    
    func configure(with title: String, version: String) {
        titleLabel.text = title
        versionLabel.text = version
    }
}

