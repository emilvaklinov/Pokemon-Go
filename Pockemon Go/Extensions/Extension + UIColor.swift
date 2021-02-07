//
//  Extension + UIColor.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 06/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.

/// MARK: Color scheme reference
// https://www.schemecolor.com/pokemon-colors.php

import UIKit

/// MARK: Pokemon color codes
extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainPink() -> UIColor {
        return UIColor.rgb(red: 255, green: 0, blue: 0)
    }
    
    static func goldenYellow() -> UIColor {
        return UIColor.rgb(red: 255, green: 222, blue: 0)
    }

    static func goldFoil() -> UIColor {
        return UIColor.rgb(red: 179, green: 161, blue: 37)
    }
    
    static func yellowPok() -> UIColor {
        return UIColor.rgb(red: 255, green: 203, blue: 5)
    }
    
    static func bluePok() -> UIColor {
        return UIColor.rgb(red: 61, green: 165, blue: 202)
    }
    
    static func navyBluePok() -> UIColor {
        return UIColor.rgb(red: 0, green: 58, blue: 112)
    }

}
