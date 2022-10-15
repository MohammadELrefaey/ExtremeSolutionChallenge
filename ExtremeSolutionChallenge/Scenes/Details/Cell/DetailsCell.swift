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
        // Initialization code
    }

    func configure(item: Items?) {
        
        let urlString = "\(item?.resourceURI ?? "")"
        imgView.setImage(with: urlString)
        titleLbl.text = item?.name

    }
}
