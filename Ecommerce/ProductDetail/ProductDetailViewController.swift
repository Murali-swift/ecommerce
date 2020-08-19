//
//  ProductDetailViewController.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit
protocol ProductDetailDisplayProtocol: DisplayLogicProtocol {
    func displayProductDetail(_ product:Products)
}

class ProductDetailViewController: UIViewController {
    weak var coordinator: ProductDetailCoordinator?
    var interactor: ProductDetailInteractorProtocol?

    var productID: Int64!
    private var products: Products?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func setup() {
        let viewController = self
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductDetailViewController: ProductDetailDisplayProtocol {
    func displayProductDetail(_ product:Products) {
        self.products = product
        
    }

}
