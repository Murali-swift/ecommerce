//
//  CategoryCollectionCell.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    private let dullOrangeColor = UIColor(red: 226 / 255, green: 171 / 255, blue: 81 / 255, alpha: 1)
    /// selected cell background color
    private let deepMarineBlueGreenColor = UIColor(red: 17 / 255, green: 45 / 255, blue: 56 / 255, alpha: 1)
    
    static let identifier = "CategoryCollectionCell"

    class func nib() -> UINib {
        UINib.init(nibName: CategoryCollectionCell.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImageView.layer.masksToBounds = false
        bgImageView.layer.shadowColor = UIColor.black.cgColor
        bgImageView.layer.shadowOffset = CGSize.zero
        bgImageView.layer.shadowRadius = 2
        bgImageView.layer.shadowOpacity = 0.2
    }

    func categorySeleccted() {
        titleLabel.textColor = dullOrangeColor
        bgImageView.backgroundColor = deepMarineBlueGreenColor
    }
    
    func categoryUnselected() {
        titleLabel.textColor = deepMarineBlueGreenColor
        bgImageView.backgroundColor = .white
    }
}
