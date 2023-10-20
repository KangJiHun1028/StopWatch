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
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StopWatchTableViewCell.identifier)

        setupUI()
    }

    private func setupUI() {
        view.addSubview(stopWatchUIView.countLabel)
        view.addSubview(stopWatchUIView.startButton)
        view.addSubview(stopWatchUIView.stopButton)
        view.addSubview(tableView)

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

            tableView.snp.makeConstraints { make in
                make.top.equalTo(stopWatchUIView.stopButton.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview() // 화면에 하단에서 부터 조정
            }
        }
    }
}

extension StopWatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopWatchTableViewCell.identifier, for: indexPath)

        cell.textLabel!.text = "Cell text"

        return cell
    }
}
