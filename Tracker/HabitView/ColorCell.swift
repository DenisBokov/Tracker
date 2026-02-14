//
//  ColorCell.swift
//  Tracker
//
//  Created by Denis Bokov on 10.02.2026.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ColorCell"
    
    override var isSelected: Bool {
        didSet {
            borderColorView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    private let borderColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .ypWhite
        view.layer.borderColor = UIColor(resource: .borderColorView).cgColor
        view.layer.borderWidth = 0
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(borderColorView)
        borderColorView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            borderColorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            colorView.centerXAnchor.constraint(equalTo: borderColorView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: borderColorView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with color: UIColor) {
        colorView.backgroundColor = color
    }
}
