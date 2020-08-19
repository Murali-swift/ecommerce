//
//  ProductCoordinator.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import UIKit
protocol ProductCoordinatorDelegate: AnyObject {
    func productCoordinatorDidSelected(id:Int64,coordinator: ProductCoordinator)
}

class ProductCoordinator: Coordinator {
    weak var delegate: ProductCoordinatorDelegate?
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
        productViewController.categoryID = categoryID
        navigationController.pushViewController(productViewController, animated: true)
//        navigationController.setViewControllers([productViewController], animated: false)
    }
}

extension ProductCoordinator {
    func productDidSelected (_ forProductID:Int64){
        delegate?.productCoordinatorDidSelected(id: forProductID, coordinator: self)
    }
}
