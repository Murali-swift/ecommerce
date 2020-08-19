//
//  ProductViewController.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit
protocol ProductDisplayProtocol: DisplayLogicProtocol{
    func displayContent(products: [Products])
}

class ProductViewController: UIViewController {
    weak var coordinator: ProductCoordinator?
    var interactor: ProductInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProductInteractor()
        let presenter = ProductPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
    }
}

extension ProductViewController: ProductDisplayProtocol {
    func displayContent(products: [Products]) {
        
    }
}
