//
//  HomeCell.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 11/10/2022.
//

import UIKit
import Kingfisher

class HomeCell: UITableViewCell {

//MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterNameLbl: UILabel!
    
//MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
//MARK: - Public Methods
    public func configure(character: CharacterResponse) {
         let urlString = "\(character.thumbnail?.path ?? "")/portrait_incredible.\(character.thumbnail?.extension_ ?? "")"
        characterImg.setImage(with: urlString)
        characterNameLbl.text = character.name ?? ""
    }
}
