//
//  MyPageViewController.swift
//  echog
//
//  Created by minsong kim on 12/26/24.
//

import Combine
import UIKit
import SnapKit

class MyPageViewController: UIViewController, View {
    var store: MyPageStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldHeadline24
        label.textColor = .black
        label.text = "마이페이지"
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        return table
    }()
    
    required init(store: MyPageStore) {
        self.store = store
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureBar()
        configureTableView()
        
        bind()
    }
    
    private func bind() {
        closeButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.goBackDiaryHome)
            }
            .store(in: &cancellables)
    }
    
    private func configureBar() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(34)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(24)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageListCell")
        var content = cell.defaultContentConfiguration()
//        if indexPath.section == 0 {
//            content.text = MyPageList.allCases[indexPath.item].title
//        } else {
            content.text = MyPageSignOut.allCases[indexPath.item].title
            content.textProperties.color = MyPageSignOut.allCases[indexPath.item].color
//        }
    
        content.textProperties.font = .mediumTitle15
        cell.contentConfiguration = content
        
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
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(.selectMyPage(indexPath))
    }
}

#Preview {
    let vc = MyPageViewController(store: MyPageStore(reducer: MyPageReducer()))
    
    return vc
}
