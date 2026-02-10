//
//  ColorCell.swift
//  Tracker
//
//  Created by Denis Bokov on 10.02.2026.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ColorCell"
    
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .ypWhite
        view.layer.borderColor = UIColor(resource: .borderColorView).cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cancelButton
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(colorView)
        colorView.addSubview(colorLabel)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            colorLabel.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            colorLabel.heightAnchor.constraint(equalToConstant: 40),
            colorLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
