//
//  DiaryEditorViewController.swift
//  echog
//
//  Created by minsong kim on 1/10/25.
//

import UIKit
import SnapKit

class DiaryEditorViewController: UIViewController {
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .regularTitle15
        
        return button
    }()
    
    private let uploadButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.regularTitle15
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("등록", attributes: titleContainer)
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .mediumTitle15
        label.text = "01월 11일 토요일"
        
        return label
    }()
    
    private let titleTextField: UITextField = {
        let text = UITextField()
        text.font = .semiboldLargetitle17
        text.placeholder = "제목을 적어주세요."
        
        return text
    }()
    
    private let contentsTextField: UITextField = {
        let text = UITextField()
        text.font = .mediumTitle15
        text.placeholder = "일기의 내용을 적어주세요."
        
        return text
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .slate100
        
        return view
    }()
    
    private let addImageButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.semiboldTitle14
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(resource: .gallery)
        configuration.attributedTitle = AttributedString("이미지 추가", attributes: titleContainer)
        configuration.baseForegroundColor = .black
        configuration.imagePadding = 8
        configuration.titleAlignment = .leading
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let addVoteButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.semiboldTitle14
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(resource: .voteCheckButton)
        configuration.attributedTitle = AttributedString("투표하기", attributes: titleContainer)
        configuration.baseForegroundColor = .black
        configuration.imagePadding = 8
        configuration.titleAlignment = .leading
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTitleBar()
        configureTextField()
        configureBottomBar()
    }
    
    private func configureTitleBar() {
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(uploadButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(50)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(50)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func configureTextField() {
        view.addSubview(titleTextField)
        view.addSubview(contentsTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        contentsTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
        }
    }
    
    private func configureBottomBar() {
        view.addSubview(addImageButton)
        view.addSubview(addVoteButton)
        view.addSubview(lineView)
        
        addImageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        addVoteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.bottom.equalTo(addVoteButton.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview()
        }
    }
}

#Preview {
    let vc = DiaryEditorViewController()
    
    return vc
}
