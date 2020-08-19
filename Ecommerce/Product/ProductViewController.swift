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
    func displayTitle(_ title:String)
}

class ProductViewController: UIViewController {
    weak var coordinator: ProductCoordinator?
    var interactor: ProductInteractorProtocol?
    var categoryID: Int64!
    private var products: [Products] = []

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        interactor?.titleForCategory(id: categoryID)
        interactor?.fetchProductForCategory(id: categoryID)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProductInteractor()
        let presenter = ProductPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCollectionCell.nib(), forCellWithReuseIdentifier: ProductCollectionCell.identifier)
        updateCollectionLayout()
    }
    
    private func updateCollectionLayout(){
        let cellRatio : CGFloat = 1.2
        let minCellWidth: CGFloat = UIScreen.main.bounds.width / 2 - 20
        let productCollectionViewLayout = CustomCollectionViewFlowLayout(minColumnWidth: minCellWidth, cellRatio: cellRatio, cellHeightExtent: 35)
        productCollectionViewLayout.minimumInteritemSpacing = 4
        productCollectionViewLayout.sectionHeadersPinToVisibleBounds = true
        productCollectionView.collectionViewLayout = productCollectionViewLayout
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductViewController: ProductDisplayProtocol {
    func displayContent(products: [Products]) {
        self.products = products
        DispatchQueue.main.async { [weak self] in
            self?.productCollectionView.reloadData()
        }
    }
    
    func displayTitle(_ title:String) {
        self.titleLabel.text = title
    }
}


extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 110.0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 12.0
//    }
//    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else {
            return UICollectionViewCell()
        }
        cell.productName.text = products[indexPath.row].name?.uppercased()
        cell.createdDateLabel.text = products[indexPath.row].date_added
        if  let variant = products[indexPath.row].variant?.allObjects.first as? Variants{
            cell.priceLabel.text = "Price $\(variant.price)"
        }
        return cell
    }
    
    
}
