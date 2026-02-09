//
//  EmojiCell.swift
//  Tracker
//
//  Created by Denis Bokov on 09.02.2026.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    static let reuseIdentifier: String = "EmojiCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
}
