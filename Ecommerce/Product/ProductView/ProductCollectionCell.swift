//
//  ProductCollectionCell.swift
//  Ecommerce
//
//  Created by Murali on 19/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    static let identifier = "ProductCollectionCell"

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    class func nib() -> UINib {
        UINib.init(nibName: ProductCollectionCell.identifier, bundle: nil)
    }

    func updateProductTitle(_ title: String) {
        productName.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
