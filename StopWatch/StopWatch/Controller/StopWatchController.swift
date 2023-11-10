//
//  ViewController.swift
//  StopWatch
//
//  Created by t2023-m0053 on 2023/10/20.
//

import SnapKit
import UIKit

class StopWatchController: UIViewController {
    // MARK: 상수, 변수 선언
    
    let stopWatchUIView = StopWatchUIView()
    var tableView = UITableView()
    var mainTimer: Timer?
    var timeCount: Int = 0
    var isStopped: Bool = false
    var historyArr = [[String: String]]()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    // MARK: 라이프 사이클

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        
        setupUI()
        buttonInit()
        tableView.reloadData()
    }

    // MARK: UI 설정

    private func setupUI() {
        view.addSubview(stopWatchUIView.countLabel)
        view.addSubview(stopWatchUIView.startButton)
        view.addSubview(stopWatchUIView.stopButton)
        view.addSubview(tableView)
        tableView.register(LogTableViewCell.self, forCellReuseIdentifier: LogTableViewCell.identifier)
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stopWatchUIView.stopButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            // 화면에 하단에서 부터 조정
            make.bottom.equalToSuperview()
        }
    }

    // MARK: 함수

    func setButton(button: UIButton, tag: ButtonTag) {
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.tag = tag.rawValue
    }
    
    @objc func buttonAction(_ button: UIButton) {
        do {
            try handleButtonAction(button)
        } catch let MyError.buttonTagError(message) {
            print(message)
        } catch {
            print("알 수 없는 오류 발생")
        }
    }
    
    func handleButtonAction(_ button: UIButton) throws {
        if let select = ButtonTag(rawValue: button.tag) {
            switch select {
            case .start:
                startAction()
            case .stop:
                if isStopped {
                    resetAction()
                } else {
                    stopAction()
                }
            }
        } else {
            throw MyError.buttonTagError("태그 오류 입니다.")
        }
    }

    func addLog(status: String, title: String, date: String) {
        let dateString = dateFormatter.string(from: Date())

        let log = ["title": title, "date": dateString, "status": status]
        historyArr.append(log)
        tableView.reloadData()
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
        let currentStatus = "start"
        let currentTime = makeTimeLabel(count: timeCount)
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        
        addLog(status: currentStatus, title: currentTime, date: currentDateString)
    }
    
    func stopAction() {
        print("stop")
        mainTimer?.invalidate()
        stopWatchUIView.startButton.isEnabled = true
        stopWatchUIView.stopButton.isEnabled = true
        isStopped = true
        let currentStatus = "stop"
        let currentTime = makeTimeLabel(count: timeCount)
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        
        addLog(status: currentStatus, title: currentTime, date: currentDateString)
    }
    
    func resetAction() {
        print("reset")
        mainTimer?.invalidate()
        timeCount = 0
        let timeString = makeTimeLabel(count: timeCount)
        stopWatchUIView.countLabel.text = timeString
        stopWatchUIView.startButton.isEnabled = true
        stopWatchUIView.stopButton.isEnabled = false
        isStopped = false
        let currentStatus = "reset"
        let currentTime = makeTimeLabel(count: timeCount)
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        
        addLog(status: currentStatus, title: currentTime, date: currentDateString)
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

// MARK: Cell 설정

extension StopWatchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.identifier, for: indexPath) as? LogTableViewCell else {
            return UITableViewCell()
        }
        let log = historyArr[indexPath.row]
        cell.configure(with: log)
        return cell
    }
}
