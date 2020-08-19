//
//  ProductDetailCoordinator.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit
//protocol ProductCoordinatorDelegate: AnyObject {
//    func productCoordinatorDidSelected(id:Int64,coordinator: ProductCoordinator)
//}

class ProductDetailCoordinator: Coordinator {
//    weak var delegate: ProductCoordinatorDelegate?
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private var productID: Int64
    let productDetailViewController = ProductDetailViewController.storyboardViewController()

    init(productID: Int64, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.productID = productID
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        productDetailViewController.coordinator = self
        productDetailViewController.productID = productID
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
}

//extension ProductCoordinator {
//    func productDidSelected (_ forProductID:Int64){
//        delegate?.productCoordinatorDidSelected(id: forProductID, coordinator: self)
//    }
//}

