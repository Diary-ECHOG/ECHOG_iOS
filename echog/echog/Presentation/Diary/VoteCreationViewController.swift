//
//  VoteCreationViewController.swift
//  echog
//
//  Created by minsong kim on 2/14/25.
//

import Combine
import UIKit
import SnapKit

final class VoteCreationViewController: UIViewController {
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "투표 제목을 적어주세요"
        textField.font = .semiboldLargetitle17
        textField.textColor = .slate800
        
        return textField
    }()
    
    private let contentsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "투표의 내용을 적어주세요"
        textField.font = .mediumTitle13
        textField.textColor = .slate600
        
        return textField
    }()
    
    private lazy var categoryButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.mediumTitle14
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .slate500
        configuration.attributedTitle = AttributedString("카테고리를 선택해 주세요.", attributes: titleContainer)
        configuration.cornerStyle = .medium
        configuration.background.strokeColor = .border
        configuration.background.strokeWidth = 1
        
        let button = UIButton(configuration: configuration)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private let dropdownImage: UIImageView = {
        let image = UIImage(systemName: "arrowtriangle.down.fill")
        let view = UIImageView(image: image)
        view.tintColor = .slate800
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let voteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .slate25
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let voteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 항목"
        label.font = .semiboldTitle15
        label.textColor = .slate600
        
        return label
    }()
    
    private let firstItemTextField = TextFieldView(placeHolder: "항목을 입력해 주세요.")
    
    private let secondItemTextField = TextFieldView(placeHolder: "항목을 입력해 주세요.")
    
    private let voteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let addItemButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.semiboldTitle15
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .actionPrimaryTonal
        configuration.baseForegroundColor = .slate600
        configuration.attributedTitle = AttributedString("항목 추가", attributes: titleContainer)
        configuration.cornerStyle = .medium
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 12
        
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    // 복수 선택 가능 스위치
    private let multipleSelectionButton = SelectionButton(isSelected: true)
    
    // 복수 선택 가능 라벨
    private let multipleSelectionLabel: UILabel = {
        let label = UILabel()
        label.text = "복수 선택 가능"
        label.font = .regularTitle14
        
        return label
    }()
    
    private let makeVoteButton = MainButton(title: "투표 만들기", isEnabled: false)
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTextField()
        configureCategoryButton()
        configureMakeVoteButton()
        configureVote()
        binds()
    }
    
    private func binds() {
        addItemButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                let newTextField = TextFieldView(placeHolder: "항목을 입력해 주세요.")
                let deleteButton = UIButton()
                deleteButton.setImage(.delete, for: .normal)
                deleteButton.tintColor = .slate800
                
                let lineStackView = UIStackView()
                lineStackView.spacing = 8
                lineStackView.alignment = .center
                lineStackView.distribution = .fill
                
                lineStackView.addArrangedSubview(newTextField)
                lineStackView.addArrangedSubview(deleteButton)
                
                self?.voteStackView.addArrangedSubview(lineStackView)
            }
            .store(in: &cancellables)
    }
    
    //title, content textfield 위치 설정
    private func configureTextField() {
        view.addSubview(titleTextField)
        view.addSubview(contentsTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        contentsTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleTextField)
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
        }
    }
    
    private func configureCategoryButton() {
        view.addSubview(categoryButton)
        view.addSubview(dropdownImage)
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(contentsTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentsTextField)
            make.height.equalTo(48)
        }
        
        dropdownImage.snp.makeConstraints { make in
            make.trailing.equalTo(categoryButton.snp.trailing).inset(16)
            make.centerY.equalTo(categoryButton.snp.centerY)
            make.height.width.equalTo(12)
        }
    }
    
    private func configureVote() {
        view.addSubview(voteBackgroundView)
        voteBackgroundView.addSubview(voteTitleLabel)
        voteBackgroundView.addSubview(voteStackView)
        voteBackgroundView.addSubview(addItemButton)
        voteBackgroundView.addSubview(multipleSelectionButton)
        voteBackgroundView.addSubview(multipleSelectionLabel)
        
        voteStackView.addArrangedSubview(firstItemTextField)
        voteStackView.addArrangedSubview(secondItemTextField)
        
        
        voteBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(8)
            make.leading.trailing.equalTo(categoryButton)
            make.bottom.equalTo(makeVoteButton.snp.top).offset(-8)
        }
        
        voteTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
        }
        
        voteStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(voteTitleLabel)
            make.top.equalTo(voteTitleLabel.snp.bottom).offset(20)
        }
        
        addItemButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(voteTitleLabel)
            make.top.equalTo(voteStackView.snp.bottom).offset(12)
            make.height.equalTo(48)
        }
        
        multipleSelectionButton.snp.makeConstraints { make in
            make.top.equalTo(addItemButton.snp.bottom).offset(12)
            make.leading.equalTo(voteTitleLabel)
            make.height.width.equalTo(16)
        }
        
        multipleSelectionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(multipleSelectionButton)
            make.leading.equalTo(multipleSelectionButton.snp.trailing).offset(8)
        }
    }
    
    private func configureMakeVoteButton() {
        view.addSubview(makeVoteButton)
        
        makeVoteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalTo(categoryButton)
            make.height.equalTo(48)
        }
    }
}

#Preview {
    let vc = VoteCreationViewController()
    
    return vc
}
