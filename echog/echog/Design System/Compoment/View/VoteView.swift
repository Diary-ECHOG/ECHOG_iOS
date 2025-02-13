//
//  VoteView.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit

/// 예: 투표 선택 항목 정보
struct SelectionOption {
    let title: String
}

class VoteView: UIView {
    private let titleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(resource: .voteCheckButton))
        
        return view
    }()
    
    // 상단의 "투표" 라벨 (제목)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투표"
        label.font = .semiboldTitle14
        label.textColor = .slate600
        
        return label
    }()
    // 상단의 "5명 투표" 등 총 투표 수
    private let totalVotesLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle13
        label.textColor = .slate400
        
        return label
    }()
    // 여러 항목들을 수직으로 나열하기 위한 스택뷰
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // 현재 선택된 항목 인덱스
    private var selectedIndex: Int?
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.border.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 레이아웃 설정
    private func configureUI() {
        self.addSubview(titleImageView)
        self.addSubview(titleLabel)
        self.addSubview(totalVotesLabel)
        self.addSubview(stackView)
        
        titleImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.height.width.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(titleImageView.snp.trailing).offset(4)
        }
        
        totalVotesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - 데이터 구성
    /// 예:  5, ["짜장면", "돈가스", "제육덮밥"]
    func configure(totalVotes: Int, options: [SelectionOption]) {
        totalVotesLabel.text = "\(totalVotes)명 투표"
        
        // 기존 스택뷰 항목 제거
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 항목별로 버튼 + 라벨 구성
        for (index, option) in options.enumerated() {
            let rowView = VoteSelectLineView(title: option.title, index: index)
            
            stackView.addArrangedSubview(rowView)
        }
    }
    
    //내가 투표했을 경우 결과 보여주기
    func update(totalVotes: Int, options: [VoteOption]) {
        totalVotesLabel.text = "\(totalVotes)명 투표"
        
        //기존 스택뷰 항목 제거
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 항목별로 버튼 + 라벨 구성
        for option in options {
            let rowView = VoteResultLineView(options: option)
            
            stackView.addArrangedSubview(rowView)
        }
    }
}
