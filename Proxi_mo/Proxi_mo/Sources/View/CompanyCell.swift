//
//  BusinessCell.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class CompanyCell: UICollectionViewCell {
    
    static var identifier: String = "cell"
    
    weak var companyLogo: UIImageView!
    weak var companyCard: UIView!
    weak var companyName: UILabel!
    weak var companySchedule: UILabel!
    weak var contentSeparator: UIView!
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.layer.borderWidth = 1.0
        logo.layer.masksToBounds = false
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.cornerRadius = 20
        logo.layer.isOpaque = true
        logo.clipsToBounds = true
        logo.contentMode = .scaleAspectFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let card: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(red: 241/255, green: 244/255, blue: 250/255, alpha: 1.0)
        card.layer.cornerRadius = 10
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    let name: UILabel = {
        let name = UILabel()
        name.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        name.textAlignment = .left
        name.numberOfLines = 0
        name.font = UIFont(name: "ProximaNova-Regular", size: 14.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let schedule: UILabel = {
        let schedule = UILabel()
        schedule.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        schedule.textAlignment = .left
        schedule.numberOfLines = 0
        schedule.font = UIFont(name: "ProximaNova-Regular", size: 11.0)
        schedule.translatesAutoresizingMaskIntoConstraints = false
        return schedule
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        
        self.companyLogo = logo
        self.companyCard = card
        self.companyName = name
        self.companySchedule = schedule
        self.contentSeparator = separator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logo.image = nil
    }
    
    private func setupUI() {
        contentView.addSubview(card)
        contentView.addSubview(logo)
        contentView.addSubview(name)
        contentView.addSubview(separator)
        contentView.addSubview(schedule)
    }
    
    private func setupConstraints() {
        card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
        card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        logo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: card.topAnchor, constant: -20).isActive = true
        
        name.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16).isActive = true
        name.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        
        separator.widthAnchor.constraint(equalToConstant: 65).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        separator.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        
        schedule.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8).isActive = true
        schedule.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        schedule.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        schedule.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
    }
}
