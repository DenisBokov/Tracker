//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Denis Bokov on 20.01.2026.
//

import UIKit

final class TrackerViewController: UIViewController {
    private let addTrackerButton = UIButton()
    private let noTrackersImageView = UIImageView()
    private let noTrackersQuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textAlignment = .center
        return label
    }()
    
    private let trackerList = Array<Any>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeAddButton())
    
        setupProfileImage(for: noTrackersImageView)
        
        if trackerList.isEmpty {
            setupLabel(noTrackersQuestionLabel)
        }
    }
    
    private func addTrackerTapped() {
        print("Нажали +")
    }
    
    private func makeAddButton() -> UIButton {
        addTrackerButton.setImage(UIImage(resource: .addPlus), for: .normal)
        
        addTrackerButton.addAction(UIAction { [weak self] _ in
            self?.addTrackerTapped()
        }, for: .touchUpInside)

        return addTrackerButton
    }
    
    private func setupProfileImage(for imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(resource: .noTrackers)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupLabel(_ label: UILabel) {
        noTrackersQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noTrackersQuestionLabel)
        
        NSLayoutConstraint.activate([
            noTrackersQuestionLabel.topAnchor.constraint(equalTo: noTrackersImageView.bottomAnchor, constant: 8),
            noTrackersQuestionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noTrackersQuestionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
