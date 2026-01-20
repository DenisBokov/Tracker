//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Denis Bokov on 20.01.2026.
//

import UIKit

final class TrackerViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    
        setupProfileImage(for: label)
    }
    
    private func setupProfileImage(for label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, AutoLayout!"
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
