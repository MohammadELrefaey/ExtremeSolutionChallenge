//
//  SearchCell.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    public func configure(character: CharacterResponse, searchQuery: String) {
        let urlString = "\(character.thumbnail?.path ?? "")/portrait_incredible.\(character.thumbnail?.extension_ ?? "")"
        characterImg.setImage(with: urlString)
        nameLbl.text = character.name ?? ""
        nameLbl.setHighlighted(character.name ?? "", with: searchQuery)
    }

}

