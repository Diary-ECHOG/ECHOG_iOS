//
//  MyVoteListViewController.swift
//  echog
//
//  Created by minsong kim on 12/26/24.
//

import UIKit
import SnapKit

class MyVoteListViewController: UIViewController {
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 투표 리스트"
        label.font = .semiboldLargetitle17
        label.textColor = .black
        
        return label
    }()
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["진행 중인 투표","완료된 투표"])
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureBar()
        configureVote()
        configureTableView()
    }
    
    private func configureBar() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(18)
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func configureVote() {
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyVoteCell.self, forCellReuseIdentifier: MyVoteCell.identifier)
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MyVoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyVoteCell.identifier, for: indexPath) as? MyVoteCell else {
            return UITableViewCell()
        }
        
        cell.configureCells(title: "점메츄", contents: "점심메뉴 뭐먹지", date: Date(), voteNumber: 5)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let line = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 1))
        line.backgroundColor = .slate100
        
        return line
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

#Preview {
    let vc = MyVoteListViewController()
    
    return vc
}
