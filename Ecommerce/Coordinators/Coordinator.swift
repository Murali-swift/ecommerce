//
//  Coordinator.swift
//  SpotiJ
//
//  Created by Murali on 14.06.20.
//  Copyright © 20wo Murali. All rights reserved.
//
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
