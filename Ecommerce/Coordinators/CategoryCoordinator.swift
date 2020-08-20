//
//  AuthCoordinator.swift
//  SpotiJ
//
//  Created by Murali on 14.06.20.
//  Copyright © 2020 Murali. All rights reserved.
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
