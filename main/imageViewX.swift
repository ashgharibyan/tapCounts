//
//  imageViewX.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/28/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit

@IBDesignable class imageViewX: UIImageView {

    
    
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
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.frame.height/2
            self.layer.frame.size.width = self.frame.height
        }
    }

}
