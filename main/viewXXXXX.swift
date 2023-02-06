//
//  viewXXXXX.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 6/4/17.
//  Copyright © 2017 ashotgharibyan. All rights reserved.
//

import UIKit

@IBDesignable class viewXXXXX: UIView {

    
        @IBInspectable var cornerRadius: CGFloat = 0{
            didSet{
                self.layer.cornerRadius = self.frame.height/2
                self.layer.frame.size.width = self.frame.height
            }
        }


}
