//
//  viewX.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/29/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit

@IBDesignable class viewX: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.frame.size.width = self.frame.height
            self.layer.cornerRadius = self.frame.width/2
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
    
    
}
