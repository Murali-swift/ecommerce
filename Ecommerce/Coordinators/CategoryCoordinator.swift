//
//  AuthCoordinator.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

class CategoryCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    let categoryViewController = CategoryViewController.storyboardViewController()

    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        categoryViewController.coordinator = self
        navigationController.setViewControllers([categoryViewController], animated: false)
    }
}
