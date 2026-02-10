//
//  HabitViewController.swift
//  Tracker
//
//  Created by Denis Bokov on 29.01.2026.
//

import UIKit

protocol HabitViewControllerDelegate: AnyObject {
    func didCreateTracker(_ tracker: Tracker, categoryName: String)
}

final class HabitViewController: UIViewController {

    private let rows = ["Категория", "Расписание"]
    
    private var selectedWeekdays: [WeekdaySchedule] = []
    
    private let emojis = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    weak var delegate: HabitViewControllerDelegate?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        label.textColor = .ypBlack
        return label
    }()
    
    private let nameTrackerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        textField.font = UIFont(name: TrackerFont.medium.rawValue, size: 17)
        textField.textColor = .nameTrackerText
        textField.backgroundColor = .nameTrackerTextField
        textField.layer.cornerRadius = 16
        textField.returnKeyType = .done
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
            textField.leftViewMode = .always
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .nameTrackerTextField
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let emojiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Emoji"
        label.font = UIFont(name: TrackerFont.bold.rawValue, size: 19)
        label.textColor = .ypBlack
        return label
    }()
    
    private let colorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = UIFont(name: TrackerFont.bold.rawValue, size: 19)
        label.textColor = .ypBlack
        return label
    }()
    
    private let emojiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 18, bottom: 24, right: 19)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 18, bottom: 24, right: 19)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(resource: .cancelButton).cgColor
        button.setTitleColor(.cancelButton, for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 16
        button.backgroundColor = .nameTrackerText
        button.setTitleColor(.ypWhite, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        tableView.register(HabitViewCell.self, forCellReuseIdentifier: HabitViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        nameTrackerTextField.delegate = self
        
        emojiCollectionView.register(
            EmojiCell.self,
            forCellWithReuseIdentifier: EmojiCell.reuseIdentifier
        )
        
        colorCollectionView.register(
            ColorCell.self,
            forCellWithReuseIdentifier: ColorCell.reuseIdentifier
        )

        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self

        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        
        cancelButton.addTarget(self, action: #selector(addCancelAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        scrollView.contentInset.bottom = 20
        scrollView.verticalScrollIndicatorInsets.bottom = 20
        
        addCancelButtonOnView()
        addSaveButtonOnView()
        
        addScrollViewOnView()
        addTitleLabelOnView()
        addTextFieldOnView()
        addTableViewOnView()
        addEmojiTitleLabelOnView()
        addEmojiCollectionViewOnView()
        addColorTitleLabelOnView()
        addColorCollectionViewOnView()
        
        updateSaveButtonState()
    }
    
    @objc private func saveTapped() {
        let schedule = Set(selectedWeekdays.compactMap { Weekday(rawValue: $0.rawValue) })
        
        let tracker = MockData.makeTracker(schedule: schedule)
        
        delegate?.didCreateTracker(tracker, categoryName: "Домашний уют")
        dismiss(animated: true)
    }
    
    @objc private func addCancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
        let isEnabled = !selectedWeekdays.isEmpty

        saveButton.isEnabled = isEnabled
        saveButton.backgroundColor = isEnabled ? .ypBlack : .nameTrackerText
    }
    
    private func addScrollViewOnView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func addTitleLabelOnView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37)
        ])
    }
    
    private func addTextFieldOnView() {
        contentView.addSubview(nameTrackerTextField)
        nameTrackerTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTrackerTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTrackerTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            nameTrackerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTrackerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTrackerTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func addTableViewOnView() {
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameTrackerTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func addEmojiTitleLabelOnView() {
        contentView.addSubview(emojiTitleLabel)
        emojiTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            emojiTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28)
        ])
    }
    
    private func addEmojiCollectionViewOnView() {
        contentView.addSubview(emojiCollectionView)
        emojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiCollectionView.topAnchor.constraint(equalTo: emojiTitleLabel.bottomAnchor, constant: 5),
            emojiCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: 204)
        ])
    }
    
    private func addColorTitleLabelOnView() {
        contentView.addSubview(colorTitleLabel)
        colorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorTitleLabel.topAnchor.constraint(equalTo: emojiCollectionView.bottomAnchor, constant: 16),
            colorTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28)
        ])
    }
    
    private func addColorCollectionViewOnView() {
        contentView.addSubview(colorCollectionView)
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: colorTitleLabel.bottomAnchor, constant: 5),
            colorCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            colorCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorCollectionView.heightAnchor.constraint(equalToConstant: 204)
        ])
    }
    
    private func addCancelButtonOnView() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    
    private func addSaveButtonOnView() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8),
            saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func openScheduleViewController() {
        let vc = ScheduleViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(vc, animated: true)
    }
    
    private func openCategoryViewController() {
        let vc = CategoryViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(vc, animated: true)
    }
}

extension HabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitViewCell.reuseIdentifier, for: indexPath) as? HabitViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.configure(title: "Категория", subtitle: nil, showDivider: true)
        case 1:
            let text = selectedWeekdays.map { $0.shortTitle }.joined(separator: ", ")
            
            cell.configure(title: "Расписание", subtitle: text, showDivider: false)
        default:
            break
        }
        
        return cell
    }
}

extension HabitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openCategoryViewController()
        case 1:
            openScheduleViewController()
        default:
            break
        }
    }
}

extension HabitViewController: ScheduleViewControllerDelegate {
    func didSelectWeekdays(_ days: [WeekdaySchedule]) {
        selectedWeekdays = days.sorted { $0.rawValue < $1.rawValue }
        tableView.reloadRows(
            at: [IndexPath(row: 1, section: 0)],
            with: .automatic
        )
        
        updateSaveButtonState()
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == emojiCollectionView {
            return emojis.count
        } else if collectionView == colorCollectionView {
            return 18
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == emojiCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: emojis[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
    }
}

extension HabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        CGSize(width: 52, height: 52)
    }
}
