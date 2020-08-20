//
//  DisplayLogic.swift
//  Ecommerce
//
//  Created by Murali on 18/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//
import UIKit
import Foundation


protocol DisplayLogicProtocol: class{
    func displayError(message: Error)
    func displayLoading()
    func removeLoading()
    func displaySuccessMessage(message: String)
}

extension UIViewController: DisplayLogicProtocol {
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
    
    func displayError(message: Error) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "ERROR",
                                          message: message.localizedDescription,
                                          preferredStyle: .alert)
            let alertOKAction=UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: { action in
            })
        
            alert.addAction(alertOKAction)
            self?.present(alert, animated: true, completion:nil)
        }
    }
    
    func displaySuccessMessage(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "SUCCESS",
                                          message: message,
                                          preferredStyle: .alert)
            let alertOKAction=UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: { action in
            })
        
            alert.addAction(alertOKAction)
            self?.present(alert, animated: true, completion:nil)
        }
    }
}
