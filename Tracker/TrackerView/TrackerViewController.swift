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
    let datePicker = UIDatePicker()
    let searchController = UISearchController()
    
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeAddButton())
        
        datePicker.datePickerMode = .date
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        setupProfileImage(for: noTrackersImageView)
        
        setupNoTrackersLabel()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy" // Формат даты
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
    
    private func addTrackerTapped() {
        print("Нажали +")
        
        let newTracker = Tracker(
            id: UUID(),
            name: "Выпить воды",
            color: TrackerColor.blue,
            emoji: "",
            schedule: [.friday, .saturday, .sunday]
        )
        
        let newCategory = TrackerCategory(heading: "Жизнь", trackers: [newTracker])
        
        categories = [newCategory]
        
        let record = TrackerRecord(trackerId: newTracker.id, date: Date())
            
        completedTrackers.append(record)
        
        print("Добавлена категория: ", categories)
        
        print("Отметка выполнения: ", completedTrackers)
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
    
    private func setupNoTrackersLabel() {
        noTrackersQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noTrackersQuestionLabel)
        
        NSLayoutConstraint.activate([
            noTrackersQuestionLabel.topAnchor.constraint(equalTo: noTrackersImageView.bottomAnchor, constant: 8),
            noTrackersQuestionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noTrackersQuestionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
