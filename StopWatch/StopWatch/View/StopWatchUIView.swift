//
//  StopWatchUIView.swift
//  StopWatch
//
//  Created by t2023-m0053 on 2023/10/20.
//

import Foundation
import SnapKit
import UIKit

class StopWatchUIView: UIViewController {
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        return button

    }()

    lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop / Reset", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()

    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
}
