//
//  SignOutReasonViewController.swift
//  echog
//
//  Created by minsong kim on 2/24/25.
//

import Combine
import UIKit
import SnapKit

class SignOutReasonViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldLargetitle17
        label.textColor = .black
        label.text = "회원탈퇴"
        
        return label
    }()
    
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.backward")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        return table
    }()
    
    private let nextButton = MainButton(title: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureBar()
        configureTableView()
        configureButton()
    }
    
    private func configureBar() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).inset(8)
            make.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SignOutReasonCell.self, forCellReuseIdentifier: SignOutReasonCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .slate100
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureButton() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }
    }
}

extension SignOutReasonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SignOutReason.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SignOutReasonCell.identifier, for: indexPath) as? SignOutReasonCell else {
            return UITableViewCell()
        }
        
        if indexPath.item == SignOutReason.allCases.count - 1 {
            cell.configureCells(title: SignOutReason.allCases[indexPath.item].title, isTextView: true)
            cell.reasonTextView.delegate = self
        } else {
            cell.configureCells(title: SignOutReason.allCases[indexPath.item].title)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let line = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 0.5))
        line.backgroundColor = .slate100
        
        return line
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == SignOutReason.allCases.count - 1 {
            172
        } else {
            56
        }
    }
}

extension SignOutReasonViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = nil
            textView.textColor = .slate800
    }
}

#Preview {
    let vc = SignOutReasonViewController()
    
    return vc
}
