//
//  AppCoordinator.swift
//  SpotiJ
//
//  Created by Murali on 14.06.20.
//  Copyright © 20wo Murali. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        showCategoryList()
    }
}

extension MainCoordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        /// Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a category view controller
        if let categoryViewController = fromViewController as? CategoryViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(categoryViewController.coordinator)
        }

        if let productViewController = fromViewController as? ProductViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(productViewController.coordinator)
        }
    }
}

// MARK: - Handler Show Login or Main View
extension MainCoordinator {
    fileprivate func showCategoryList() {
        let categoryCoordinator = CategoryCoordinator(navigationController: navigationController)
        categoryCoordinator.delegate = self
        categoryCoordinator.parentCoordinator = self
        categoryCoordinator.start()
        childCoordinators.append(categoryCoordinator)
    }

    fileprivate func showProductList(_ id: Int64) {
        let productoordinator = ProductCoordinator(categoryID: id, navigationController: navigationController)
        productoordinator.delegate = self
        productoordinator.parentCoordinator = self
        productoordinator.start()
        childCoordinators.append(productoordinator)
    }
    
    fileprivate func showProductDetail(_ id: Int64) {
        let productDetailCoordinator = ProductDetailCoordinator(productID: id, navigationController: navigationController)
        productDetailCoordinator.parentCoordinator = self
        productDetailCoordinator.start()
        childCoordinators.append(productDetailCoordinator)
    }
}

// MARK: - Delegate Authentication Coordinator
extension MainCoordinator: CategoryCoordinatorDelegate {
    func categoryCoordinatorDidSelected(id: Int64, coordinator: CategoryCoordinator) {
       showProductList(id)
    }
}


extension MainCoordinator: ProductCoordinatorDelegate {
    func productCoordinatorDidSelected(id: Int64, coordinator: ProductCoordinator) {
        showProductDetail(id)
    }
}
