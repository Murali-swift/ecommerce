//
//  ColorSupport.swift
//  Ecommerce
//
//  Created by Murali on 20/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import UIKit

final class Color {
    static func name(_ name:String?) -> UIColor{
        switch name {
        case "black": return UIColor.black
        case "white": return UIColor.white
        case "red": return UIColor.red
        case "green": return UIColor.green
        case "blue": return UIColor.blue
        case "yellow": return UIColor.yellow
        case "orange": return UIColor.orange
        case "purple": return UIColor.purple
        case "brown": return UIColor.brown
        default: return UIColor.white
        }
    }
}

