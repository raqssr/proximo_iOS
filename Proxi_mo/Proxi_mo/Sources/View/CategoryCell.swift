//
//  BusinessTypeCell.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    static var identifier: String = "cell"
    
    weak var categoryName: UILabel!
    
    let name: UILabel = {
        let cat = UILabel()
        cat.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        cat.textAlignment = .center
        cat.numberOfLines = 0
        cat.font = UIFont(name: "ProximaNova-Regular", size: 14.0)
        cat.translatesAutoresizingMaskIntoConstraints = false
        return cat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()

        self.categoryName = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(name)
    }
    
    private func setupConstraints() {
        contentView.centerXAnchor.constraint(equalTo: name.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
}
