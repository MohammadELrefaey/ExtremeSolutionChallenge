//
//  DetailsCell.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(item: Items?) {

        imgView.setImage(with: item?.resourceURI ?? "")
        getItem(uri: item?.resourceURI ?? "")
        titleLbl.text = item?.name

    }
    
    private func getItem(uri: String) {
        APIManager.shared.getItem(uri: uri) { [weak self] response, errorResponse, error in
            guard let self = self else {return}
            if let item = response?.data?.results?[0] {
                let urlString = "\(item.thumbnail?.path ?? "")/portrait_incredible.\(item.thumbnail?.extension_ ?? "")"
                DispatchQueue.main.async {
                    self.imgView.setImage(with: urlString)
                }
            }
        }

    }

    
}
