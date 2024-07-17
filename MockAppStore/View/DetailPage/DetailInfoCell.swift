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
    @IBOutlet weak var iconImageView: UIImageView!
    
    private lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var numberOfStars: Double = 0.0
    
    func configureCell(_ model: DetailModel, numberOfStars: Double) {
        topicLabel.text = model.topic
        
        switch model.content {
        case .text(let text):
            contentLabel.text = text
            iconImageView.isHidden = true
            contentLabel.isHidden = false
        case .image(let image):
            iconImageView.image = image
            iconImageView.isHidden = false
            contentLabel.isHidden = true
        case .stackView:
            return
        }
        
        switch model.detail {
        case.text(let text):
            bottomLabel.text = text
            starStackView.isHidden = true
            bottomLabel.isHidden = false
        case .stackView:
            starStackView.isHidden = false
            bottomLabel.isHidden = true
            setupStarUI()
            updateNumberOfStars(numberOfStars)
        case .image:
            return
        }

    }
    
    private func setupStarUI() {
        // Remove all existing subviews
        for subview in starStackView.arrangedSubviews {
            starStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        if starStackView.superview == nil {
            contentView.addSubview(starStackView)
            NSLayoutConstraint.activate([
                starStackView.heightAnchor.constraint(equalToConstant: 30),
                starStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                starStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                starStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }
        createStars()
    }
    
    private func createStars() {
        for index in 1...5 {
            let star = makeStarIcon()
            star.tag = index
            starStackView.addArrangedSubview(star)
        }
    }
    
    // 創造空心的星星
    private func makeStarIcon() -> UIImageView {
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }
    
    private func updateNumberOfStars(_ numberOfStars: Double) {
        self.numberOfStars = numberOfStars
        updateStarIcons()
    }
    
    private func updateStarIcons() {
        for (index, starView) in starStackView.arrangedSubviews.enumerated() {
            guard let starImageView = starView as? UIImageView else { return }
            let fillLevel = numberOfStars - Double(index)
            
            if fillLevel >= 1 {
                starImageView.image = UIImage(systemName: "star.fill")
            } else if fillLevel > 0 {
                let partialFillImage = getPartialFillStarImage(fillLevel: fillLevel)
                starImageView.image = partialFillImage
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
    }
    
    private func getPartialFillStarImage(fillLevel: Double) -> UIImage? {
        guard let unfilledStar = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate),
              let filledStar = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate) else {
            return nil
        }
        
        let size = unfilledStar.size
        let tintColor = UIColor.systemGray
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            // Draw the unfilled star
            context.setFillColor(tintColor.cgColor)
            unfilledStar.draw(in: CGRect(origin: .zero, size: size))
            
            // Draw the filled part of the star
            let filledRect = CGRect(x: 0, y: 0, width: size.width * CGFloat(fillLevel), height: size.height)
            let clipRect = CGRect(x: 0, y: 0, width: filledRect.width, height: size.height)
            context.clip(to: clipRect)
            filledStar.draw(in: CGRect(origin: .zero, size: size))
            
            let partialFillImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return partialFillImage
        }
        return nil
    }
    
}
