//
//  CategoryViewController.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

struct Constants {
    static let loadingViewTag = 100
    static let baseURLString = "https://api.jsonbin.io"
}

protocol DisplayLogicProtocol: class{
    func displayError(message: Error)
    func displayLoading()
    func removeLoading()
}

protocol CategoryDisplayProtocol: DisplayLogicProtocol{
    func displayContent(message: Category)
}

extension DisplayLogicProtocol where Self: UIViewController {
    func displayLoading() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.animate()
        loadingView.tag = Constants.loadingViewTag
    }
    
    func removeLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.subviews.forEach { subview in
                if subview.tag == Constants.loadingViewTag {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

class CategoryViewController: UIViewController {
    weak var coordinator: CategoryCoordinator?
    var interactor: CategoryInteractorProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadCategory()
    }
    
    
    private func setup() {
        let viewController = self
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func loadCategory(){
        interactor?.fetchCategory()
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
}
