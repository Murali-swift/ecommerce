//
//  AuthCoordinator.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit
protocol CategoryCoordinatorDelegate: AnyObject {
    func categoryCoordinatorDidSelected(id:Int64,coordinator: CategoryCoordinator)
}

class CategoryCoordinator: Coordinator {
    weak var delegate: CategoryCoordinatorDelegate?
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

extension CategoryCoordinator {
    func categoryDidSelected (_ forCategoryId:Int64){
        delegate?.categoryCoordinatorDidSelected(id: forCategoryId, coordinator: self)
    }
}
