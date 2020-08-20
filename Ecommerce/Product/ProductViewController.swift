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
    func updateFilter(_ ranking:[Ranking])
}

class ProductViewController: UIViewController {
    weak var coordinator: ProductCoordinator?
    var interactor: ProductInteractorProtocol?
    var categoryID: Int64!
    private var products: [Products] = []
    private var ranking: [Ranking] = []

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        interactor?.titleForCategory(id: categoryID)
        interactor?.fetchProductForCategory(id: categoryID, filter: nil)
        interactor?.fetchRankingFilter()
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
        let productCollectionViewLayout = CustomCollectionViewFlowLayout(minColumnWidth: UIScreen.main.bounds.width / 2 - 20, cellRatio: 1.2, cellHeightExtent: 35)
        productCollectionViewLayout.minimumInteritemSpacing = 4
        productCollectionViewLayout.sectionHeadersPinToVisibleBounds = true
        productCollectionView.collectionViewLayout = productCollectionViewLayout
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = sender // UIView or UIBarButtonItem
        let frame = view.convert(sender.frame, from: sender.superview!)
        dropDown.bottomOffset = CGPoint(x: 0, y: frame.height)
        dropDown.topOffset = CGPoint(x: 0, y: -frame.height)
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ranking.compactMap({$0.ranking})
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.interactor?.fetchProductForCategory(id: self.categoryID, filter: item)
        }
        
        dropDown.backgroundColor = .white
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) in
            cell.optionLabel.textAlignment = .center
        }
        dropDown.show()
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
    
    func updateFilter(_ ranking:[Ranking]) {
        self.ranking = ranking
    }
}


extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else {
            return UICollectionViewCell()
        }
        cell.productName.text = products[indexPath.row].name?.uppercased()
        cell.createdDateLabel.text = products[indexPath.row].date_added
        if  let variant = products[indexPath.row].variant?.array.first as? Variants{
            cell.priceLabel.text = "Price $\(variant.price)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.productDidSelected(products[indexPath.row].id)
    }
}
