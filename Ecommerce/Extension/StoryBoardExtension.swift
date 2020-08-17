//
//  storyBoardExtension.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        return String(describing: self)
    }
    
    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return vc
    }
}

extension UIViewController: Storyboardable { }
