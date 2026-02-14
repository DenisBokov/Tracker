//
//  EmojiCell.swift
//  Tracker
//
//  Created by Denis Bokov on 09.02.2026.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    static let reuseIdentifier: String = "EmojiCell"
    
    override var isSelected: Bool {
        didSet {
            emojiView.backgroundColor = isSelected ? .borderColorView : .ypWhite
        }
    }
    
    private let emojiView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textColor = .ypWhiteAndGrey
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
        contentView.addSubview(emojiView)
        emojiView.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            emojiView.topAnchor.constraint(equalTo: contentView.topAnchor),
            emojiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            emojiLabel.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor)
        ])
    }
    
    func configure(with emoji: String) {
        emojiLabel.text = emoji
    }
}
