//
//  CategoryViewController.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

protocol CategoryDisplayProtocol: DisplayLogicProtocol{
    func displayContent(categories: [Category])
    func displayMainContent(_ titles: [String])
    func displayDefaultCategory(_ titles:String)
}

class CategoryViewController: UIViewController {
    weak var coordinator: CategoryCoordinator?
    var interactor: CategoryInteractorProtocol?
    private var categories: [Category] = []
    private var mainCategories: [String] = []
    private var selectedMainCategory = ""

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadCategory()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setup() {
        let viewController = self
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        self.setupTableView()
        self.setUpCollectionView()
    }
    
    private func setupTableView() {
        categoryTableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.tableFooterView = UIView()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionCell.nib(), forCellWithReuseIdentifier: CategoryCollectionCell.identifier)
    }
    
    private func loadCategory(){
        interactor?.fetchMainCategory()
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].subCategories?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView,heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell  else {
            return UIView()
        }
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = categories[section].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell  else {
            return UITableViewCell()
        }

        cell.textLabel?.text = ""
        interactor?.fetchSubCategory(mainCategory: categories[indexPath.section], forIndexPath: indexPath, completion: { (subCategory) in
            cell.textLabel?.text = subCategory?.name
        })
        
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.fetchSubCategory(mainCategory: categories[indexPath.section], forIndexPath: indexPath, completion: { (subCategory) in
            coordinator?.categoryDidSelected(subCategory!.id)
        })
    }
}

extension CategoryViewController: CategoryDisplayProtocol {
    func displayMainContent(_ titles: [String]) {
        self.mainCategories = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func displayContent(categories: [Category]) {
        self.categories = categories
        DispatchQueue.main.async { [weak self] in
            self?.categoryTableView.reloadData()
        }
    }
    
    func displayDefaultCategory(_ titles:String) {
        selectedMainCategory = titles
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth: CGFloat = width/2 - 10.0
        return CGSize(width: cellWidth, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        cell.titleLabel.text = mainCategories[indexPath.row]
        selectedMainCategory == mainCategories[indexPath.row] ? cell.categorySeleccted() : cell.categoryUnselected()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMainCategory = mainCategories[indexPath.row]
        self.interactor?.fetchRelatedCategory(forTitle: selectedMainCategory)
    }
}


