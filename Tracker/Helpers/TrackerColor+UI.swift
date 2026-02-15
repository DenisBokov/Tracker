//
//  TrackerColor+UI.swift
//  Tracker
//
//  Created by Denis Bokov on 15.02.2026.
//

import UIKit

extension TrackerColor {
    var trackerUiColor: UIColor {
        UIColor(named: rawValue) ?? .clear
    }
}
