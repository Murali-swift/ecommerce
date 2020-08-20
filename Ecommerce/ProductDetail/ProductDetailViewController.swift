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
    func updateVariantUI(selectedID:Int64,variants: [Variants])
}

class ProductDetailViewController: UIViewController {
    weak var coordinator: ProductDetailCoordinator?
    var interactor: ProductDetailInteractorProtocol?
    var productID: Int64!
    private var products: Products?
//    private var variants: [Variants] = []
    private var defaultSelectedVariantID: Int64?
    
    @IBOutlet weak var variantsStackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        interactor?.fetchProduct(id: productID)
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func updateUI(){
        titleLabel.text = products?.name
        taxLabel.text = "Tax (\(products?.tax?.name ?? "")): \(products?.tax?.value ?? 0.0)"
    }
    
    private func updateSelectedVarient(_ variant: UIView) {
        let color: UIColor = .black
        variant.layer.borderColor = color.cgColor
        variant.layer.borderWidth = 1.5
        variant.layer.cornerRadius = 8.0
    }
    
    private func deSelectVarient(_ variant: UIView) {
        let color: UIColor = .clear
        variant.layer.borderColor = color.cgColor
    }
    
    private func updateVariantUI(_ variants: [Variants]){
        var selectedVariant: Variants?
        let views = variantsStackView.arrangedSubviews
        for (index,item) in variants.enumerated() {
            views[index].isHidden = false
            views[index].tag = Int(item.id)
            views[index].backgroundColor = Color.name(item.color?.lowercased())
            if defaultSelectedVariantID == item.id {
                updateSelectedVarient(views[index])
                selectedVariant = item
            }else {
                deSelectVarient(views[index])
            }
        }
        if let selectedVariant = selectedVariant {
            sizeLabel.text = "Size \(selectedVariant.size)"
            priceLabel.text = "Price \(selectedVariant.price)"
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        interactor?.addToCard(id: productID)
    }
    
    @IBAction func buyNow(_ sender: Any) {
        interactor?.buyCard(id: productID)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func variantSelected(_ sender: UIButton) {
        interactor?.fetchVariant(id: Int64(sender.tag))
    }
}

extension ProductDetailViewController: ProductDetailDisplayProtocol {
    func displayProductDetail(_ product:Products) {
        self.products = product
        updateUI()
    }

    func updateVariantUI(selectedID:Int64,variants: [Variants]) {
//        self.variants = variants
        self.defaultSelectedVariantID = selectedID
        updateVariantUI(variants)
    }
    
}
