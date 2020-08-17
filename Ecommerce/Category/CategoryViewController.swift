//
//  CategoryViewController.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

protocol DisplayLogicProtocol: class{
    func displayError(message: Error)
    func displayLoading()
    func removeLoading()
}

protocol CategoryDisplayProtocol: DisplayLogicProtocol{
    func displayContent(message: Category)
}

class CategoryViewController: UIViewController {
    weak var coordinator: CategoryCoordinator?
    var interactor: CategoryInteractorProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    
    private func setup() {
        let viewController = self
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter()
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

extension CategoryViewController: CategoryDisplayProtocol {
    func displayContent(message: Category) {
        
    }
    
    func displayError(message: Error) {
        
    }
    
    func displayLoading() {
        
    }
    
    func removeLoading() {
        
    }
    
    
}
