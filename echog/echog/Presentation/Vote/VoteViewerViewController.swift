//
//  VoteViewerViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit

final class VoteViewerViewController: UIViewController {
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.backward")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "ellipsis")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let categoryLabel = ChipLabel(text: "일상")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .slate800
        label.font = .semiboldLargetitle17
        label.text = "제목입니다."
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .slate600
        label.font = .regularTitle15
        label.text = "내용입니다."
        
        return label
    }()
    
    private let voteDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .slate400
        label.font = .regularTitle13
        label.text = "익명 18 · 11월 21일 목요일"
        
        return label
    }()
    
    private let voteSelectionView = VoteSelectionView()
    private let voteButton = MainButton(title: "투표하기", isEnabled: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitleBar()
        configureCategoryLabel()
        configureLabels()
        configurevoteButton()
        configureVoteView()
        configureVoteDateLabel()
    }
    
    //네비게이션 바 커스텀
    private func configureTitleBar() {
        view.addSubview(backButton)
        view.addSubview(settingButton)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalTo(backButton)
        }
    }
    
    //카테고리 설정
    private func configureCategoryLabel() {
        view.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(22)
        }
    }
    
    //제목 및 내용 설정
    private func configureLabels() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.leading.equalTo(categoryLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel)
        }
    }
    
    //투표 닉네임, 날짜 라벨 위치 설정
    private func configureVoteDateLabel() {
        view.addSubview(voteDateLabel)
        
        voteDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(voteSelectionView.snp.top).offset(-8)
            make.leading.equalTo(voteSelectionView)
        }
    }
    
    //투표 설정
    private func configureVoteView() {
        voteSelectionView.configure( totalVotes: 5, options: [SelectionOption(title: "돈까스"), SelectionOption(title: "냉면"), SelectionOption(title: "삼겹살")])
        
        view.addSubview(voteSelectionView)
        
        voteSelectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(22)
            make.bottom.equalTo(voteButton.snp.top).offset(-12)
        }
    }
    
    //투표 버튼 설정
    private func configurevoteButton() {
        view.addSubview(voteButton)
        
        voteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(48)
        }
    }
}

#Preview {
    let vc = VoteViewerViewController()
    
    return vc
}
