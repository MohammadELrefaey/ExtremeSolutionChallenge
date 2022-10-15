//
//  Extension+UIView.swift
//  ExtremeSolutionChallenge
//
//  Created by Refa3y on 11/10/2022.
//

import Foundation
import UIKit

extension UIView {
   open override func awakeFromNib() {
       self.clipsToBounds = true
   }
   
   @IBInspectable var cornerRadius: CGFloat {
       set {
           layer.cornerRadius = newValue
       }
       get {
           return layer.cornerRadius
       }
   }
}
