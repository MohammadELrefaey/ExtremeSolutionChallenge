//
//  Extensions+UILabel+Highlight.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 15/10/2022.
//

import UIKit

extension UILabel {
    func setHighlighted(_ text: String, with search: String) {
        let attributedText = NSMutableAttributedString(string: text) // 1
        let range = NSString(string: text).range(of: search, options: .caseInsensitive) // 2
        let highlightColor =  UIColor.red  // 3
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: highlightColor] // 4
        
        attributedText.addAttributes(highlightedAttributes, range: range) // 5
        self.attributedText = attributedText // 6
    }
}
