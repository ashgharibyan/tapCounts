//
//  CircleButton.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/22/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return UIBezierPath(ovalIn: bounds).contains(point)
    }


}
