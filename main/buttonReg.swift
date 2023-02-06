//
//  buttonReg.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 6/4/17.
//  Copyright © 2017 ashotgharibyan. All rights reserved.
//

import UIKit

@IBDesignable class buttonReg: UIButton {
    
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet{
                self.layer.cornerRadius = cornerRadius
            }
        }
        
        @IBInspectable var borderWidth: CGFloat = 0{
            didSet{
                self.layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var borderColor: UIColor = UIColor.clear {
            didSet{
                self.layer.borderColor = borderColor.cgColor
            }
        }
        
        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            return UIBezierPath(ovalIn: bounds).contains(point)
        }
        
    
}
