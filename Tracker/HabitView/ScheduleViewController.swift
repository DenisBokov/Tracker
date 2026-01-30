//
//  Untitled.swift
//  Tracker
//
//  Created by Denis Bokov on 30.01.2026.
//

import UIKit

final class ScheduleViewController:UIViewController {
    
    let weakdays: [String] = [
        "Понедельник",
        "Вторник",
        "Среда",
        "Четверг",
        "Пятница",
        "Суббота",
        "Воскресенье"
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        label.textColor = .ypBlack
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .nameTrackerTextField
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let saveScheduleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: TrackerFont.medium.rawValue, size: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlack
        button.setTitleColor(.ypWhite, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        addTitleLabelOnView()
        addTableViewOnView()
        addSaveScheduleButtonOnView()
    }
    
    private func addTitleLabelOnView() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37)
        ])
    }
    
    private func addTableViewOnView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 525)
        ])
    }
    
    private func addSaveScheduleButtonOnView() {
        view.addSubview(saveScheduleButton)
        saveScheduleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveScheduleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveScheduleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveScheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveScheduleButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weakdays.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier, for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.configure(title: "Понедельник", showDivider: true)
        case 1:
            cell.configure(title: "Вторник", showDivider: true)
        case 2:
            cell.configure(title: "Понедельник", showDivider: true)
        case 3:
            cell.configure(title: "Вторник", showDivider: true)
        case 4:
            cell.configure(title: "Понедельник", showDivider: true)
        case 5:
            cell.configure(title: "Вторник", showDivider: true)
        case 6:
            cell.configure(title: "Понедельник", showDivider: false)
        default:
           break
        }
        
        return cell
    }
}
