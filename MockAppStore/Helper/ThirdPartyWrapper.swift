//
//  ThirdPartyWrapper.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
