//
//  ViewController.swift
//  StopWatch
//
//  Created by t2023-m0053 on 2023/10/20.
//

import SnapKit
import UIKit
class StopWatchController: UIViewController {
    let stopWatchUIView = StopWatchUIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        view.addSubview(stopWatchUIView.countLabel)
        view.addSubview(stopWatchUIView.startButton)
        view.addSubview(stopWatchUIView.stopButton)

        stopWatchUIView.countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.centerX.equalTo(view.snp.centerX)
        }

        stopWatchUIView.startButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-200)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }

        stopWatchUIView.stopButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(200)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
}
