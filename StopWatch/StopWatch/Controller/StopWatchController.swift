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
    var mainTimer: Timer?
    var timeCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StopWatchTableViewCell.identifier)
        
        setupUI()
        buttonInit()
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
                // 화면에 하단에서 부터 조정
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func setButton(button: UIButton, tag: ButtonTag) {
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.tag = tag.rawValue
    }
    
    @objc func buttonAction(_ button: UIButton) {
        if let select = ButtonTag(rawValue: button.tag) {
            do {
                switch select {
                case .start:
                    try startAction()
                case .stop:
                    try stopAction()
                }
            } catch {
                print("오류가 발생했습니다.")
            }
        } else {
            print("알 수 없는 버튼 태그입니다.")
        }
    }

    func startAction() {
        print("start")
        stopWatchUIView.startButton.isEnabled = false
        stopWatchUIView.stopButton.isEnabled = true
        mainTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            self.timeCount += 1
            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timeCount)
                self.stopWatchUIView.countLabel.text = timeString
            }
        })
    }
    
    func stopAction() {
        print("stop")
        stopWatchUIView.startButton.isEnabled = true
        stopWatchUIView.stopButton.isEnabled = false
    }
    
    func buttonInit() {
        setButton(button: stopWatchUIView.startButton, tag: .start)
        setButton(button: stopWatchUIView.stopButton, tag: .stop)
    }
    
    func makeTimeLabel(count: Int) -> (String) {
        let hundredthSec = count % 100
        let sec = (count / 100) % 60
        let min = (count / 100) / 60
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        let hundredthSecString = "\(hundredthSec)".count == 1 ? "0\(hundredthSec)" : "\(hundredthSec)"
        return "\(minString):\(secString):\(hundredthSecString)"
    }
}

extension StopWatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopWatchTableViewCell.identifier, for: indexPath)

        return cell
    }
}
