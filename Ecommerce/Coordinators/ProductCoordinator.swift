//
//  ProductCoordinator.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import UIKit


class ProductCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private var categoryID: Int64
    let productViewController = ProductViewController.storyboardViewController()

    init(categoryID: Int64, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.categoryID = categoryID
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        productViewController.coordinator = self
        navigationController.pushViewController(productViewController, animated: true)
//        navigationController.setViewControllers([productViewController], animated: false)
    }
}
