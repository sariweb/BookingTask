//
//  OptionsTableViewCell.swift
//  BookingTask
//
//  Created by Sergei on 15.09.2023.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    static let identifier = "OptionsTableViewCell"

    private var optionIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    
    private var optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.starsFont
        label.textColor = Theme.optionColor
        
        return label
    }()
    
    private var optionDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.addressFont
        label.textColor = Theme.descriptionLabelColor //background: #FFA800;
        
        return label
    }()
    
    private var arrowIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: OptionsTableViewCell.identifier)
        
        contentView.addSubview(optionIconView)
        contentView.addSubview(optionLabel)
        contentView.addSubview(optionDescLabel)
        contentView.addSubview(arrowIconView)
        contentView.backgroundColor = Theme.cellBgColor
        setupConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            optionIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.margin),
            
            optionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            optionLabel.leadingAnchor.constraint(equalTo: optionIconView.trailingAnchor, constant: 12),
            
            optionDescLabel.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 2),
            optionDescLabel.leadingAnchor.constraint(equalTo: optionLabel.leadingAnchor),
            optionDescLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            arrowIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

        ])
    }

    // MARK: Configure cell
    
    public func configure(viewModel: OptionCellViewModel) {
        optionIconView.image = UIImage(named: viewModel.optionIcon)
        optionLabel.text = viewModel.option
        optionDescLabel.text = viewModel.optionDesc
    }
}
