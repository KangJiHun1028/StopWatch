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
    public lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        return button

    }()

    public lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop / Reset", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
}
