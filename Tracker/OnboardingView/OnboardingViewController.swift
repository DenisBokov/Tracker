//
//  OnboardingOneController.swift
//  Tracker
//
//  Created by Denis Bokov on 05.02.2026.
//

import UIKit

final class OnboardingViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: TrackerFont.bold.rawValue, size: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let nextPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вот это технологии", for: .normal)
        button.titleLabel?.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlack
        button.setTitleColor(.ypWhite, for: .normal)
        return button
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .onbordingOne
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    @objc private func continueTapped() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.hasSeenOnboarding.rawValue)

        let mainVC = MainTabBarController()
        mainVC.modalPresentationStyle = .fullScreen

        present(mainVC, animated: true)
    }
    
    private func addBackgroundImageViewOnView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func addTitleLabelOnView() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: nextPageButton.topAnchor, constant: 160),
        ])
    }
    
    private func addNextPageButtonOnView() {
        view.addSubview(nextPageButton)
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextPageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            nextPageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextPageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextPageButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
