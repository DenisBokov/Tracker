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
    
    private let datePicker = UIDatePicker()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
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
        
        setupSearchController()
        
        setupCollectionViewConstraints()
        
        collectionView.register(
            TrackerCell.self,
            forCellWithReuseIdentifier: TrackerCell.reuseIdentifier
        )
        
        collectionView.register(
            TrackerSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerSectionHeader.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupProfileImage(for: noTrackersImageView)
        
        setupNoTrackersLabel()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    private func addTrackerTapped() {
        print("Нажали +")
        
        let newTracker = Tracker(
            id: UUID(),
            name: "Полить растения",
            color: .green,
            emoji: "😪",
            schedule: [.friday, .saturday, .sunday]
        )
        
        let categoryName = "Жизнь"
        
        if let index = categories.firstIndex(where: { $0.heading == categoryName }) {
            categories[index].trackers.append(newTracker)
        } else {
            let newCategory = TrackerCategory(heading: categoryName, trackers: [newTracker])
            categories.append(newCategory)
        }
        
        noTrackersImageView.isHidden = true
        noTrackersQuestionLabel.isHidden = true
        
        collectionView.reloadData()
    }
    
    private func quantityButtonTapped() {
        
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

extension TrackerViewController: UICollectionViewDataSource, TrackerCellDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories[section].trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TrackerSectionHeader.reuseIdentifier,
            for: indexPath) as? TrackerSectionHeader
        else {
            return UICollectionReusableView()
        }
        
        headerView.configure(withTitle: categories[indexPath.section].heading)
        
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerCell.reuseIdentifier,
            for: indexPath
        ) as? TrackerCell else {
            
            return UICollectionViewCell()
        }
        
        let tracker = categories[indexPath.section].trackers[indexPath.item]
        
        let isComplitedToday = completedTrackers.contains { record in
            record.trackerId == tracker.id && Calendar.current.isDateInToday(record.date ?? Date())
        }
        
        let completedCount = completedTrackers.filter { record in
            record.trackerId == tracker.id
        }.count
        
        cell.configure(with: tracker, countDays: completedCount, isCompleted: isComplitedToday)
        cell.delegate = self
        
        return cell
    }
    
    func trackerCellDidTapQuantityButton(_ cell: TrackerCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let tracker = categories[indexPath.section].trackers[indexPath.item]
        
        let today = Date()
        
        // Нельзя для будущей даты
        if Calendar.current.compare(today, to: datePicker.date, toGranularity: .day) == .orderedAscending {
            return
        }
        
        if let index = completedTrackers.firstIndex(where: { $0.trackerId == tracker.id && Calendar.current.isDate($0.date ?? today, inSameDayAs: today) }) {
            // Уже выполнен сегодня — убрать отметку
            completedTrackers.remove(at: index)
        } else {
            // Добавляем отметку
            let record = TrackerRecord(trackerId: tracker.id, date: today)
            completedTrackers.append(record)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}

extension TrackerViewController: UICollectionViewDelegate {
    
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let width = (collectionView.bounds.width - 16 * 2 - 8) / 2
        return CGSize(width: width, height: 148)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        
        CGSize(width: collectionView.bounds.width, height: 40)
    }
}
