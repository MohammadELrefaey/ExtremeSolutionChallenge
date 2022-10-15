//
//  Extension+UIImageView.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import Foundation
import Kingfisher

let defImage = UIImage(named: "image-placeholder")

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {return}
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource, placeholder: defImage)
    }
}
