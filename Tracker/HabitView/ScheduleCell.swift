//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Denis Bokov on 30.01.2026.
//

import UIKit

final class ScheduleCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ScheduleCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: TrackerFont.medium.rawValue, size: 17)
        label.textColor = .ypBlack
        return label
    }()
    
    private let isActiveSwitch: UISwitch = {
       let switchView = UISwitch()
        switchView.onTintColor = .launchScreen
        return switchView
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .nameTrackerText
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTableViewCell() {
        backgroundColor = .clear
        contentView.layer.masksToBounds = true

        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomDivider)
        contentView.addSubview(isActiveSwitch)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        isActiveSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            isActiveSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            isActiveSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            isActiveSwitch.widthAnchor.constraint(equalToConstant: 24),
//            isActiveSwitch.heightAnchor.constraint(equalToConstant: 24),
            
            bottomDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomDivider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configure(title: String, showDivider: Bool) {
        titleLabel.text = title
        bottomDivider.isHidden = !showDivider
    }
}
