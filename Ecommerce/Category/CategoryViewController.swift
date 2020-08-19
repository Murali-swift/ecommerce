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
}


class CategoryViewController: UIViewController {
    weak var coordinator: CategoryCoordinator?
    var interactor: CategoryInteractorProtocol?

    @IBOutlet weak var categoryTableView: UITableView!
    private var categories: [Category] = []
    
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
    }
    
    private func setupTableView() {
        categoryTableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.tableFooterView = UIView()
    }
    
    private func loadCategory(){
        interactor?.fetchMainCategory()
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
        coordinator?.productDidSelected(categories[indexPath.row].id)
    }
}

extension CategoryViewController: CategoryDisplayProtocol {
    func displayContent(categories: [Category]) {
        self.categories = categories
        DispatchQueue.main.async { [weak self] in
            self?.categoryTableView.reloadData()
        }
    }
}

