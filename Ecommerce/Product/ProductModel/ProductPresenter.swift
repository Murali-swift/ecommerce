//
//  ProductPresenter.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol ProductPresenterProtocol:ErrorPresenter {
    func updateProduct(_ product:[Products])
    func updateTitle(_ title:String)
    func updateFilter(_ ranking:[Ranking])
}


class ProductPresenter:ProductPresenterProtocol {
    weak var viewController: ProductDisplayProtocol?

    func updateProduct(_ product: [Products]) {
        viewController?.displayContent(products: product)
    }
    
    func updateTitle(_ title:String) {
        viewController?.displayTitle(title)
    }
    
    func updateFilter(_ ranking:[Ranking]) {
        viewController?.updateFilter(ranking)
    }
    
    func showError(_ error: Error) {
        viewController?.displayError(message: error)
    }

}
