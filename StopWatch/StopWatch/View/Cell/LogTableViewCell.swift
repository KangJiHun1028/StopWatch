//
//  StopWatchTableViewCell.swift
//  StopWatch
//
//  Created by t2023-m0053 on 2023/10/21.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    static let identifier = "LogTableViewCell"

    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let statusLabel = UILabel()
    // 클래스 선언 및 변수 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("구현되지 않았습니다.")
    }

    // 초기화 메서드

    private func setupUI() {
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(statusLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    // UI 설정

    func configure(with log: [String: String]) {
        titleLabel.text = log["title"]
        dateLabel.text = log["date"]
        statusLabel.text = log["status"]
    }
}

// 셀 구성
