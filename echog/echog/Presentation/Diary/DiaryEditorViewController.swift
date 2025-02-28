//
//  DiaryEditorViewController.swift
//  echog
//
//  Created by minsong kim on 1/10/25.
//

import Combine
import UIKit
import SnapKit

class DiaryEditorViewController: UIViewController, View {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    var store: DiaryStore
    private var cancellables = Set<AnyCancellable>()
    
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
        
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM월 dd일 EEEE"
        
        label.text = formatter.string(from: Date())
        
        return label
    }()
    
    private let titleTextField: UITextField = {
        let text = UITextField()
        text.font = .semiboldLargetitle17
        text.placeholder = "제목을 적어주세요."
        
        return text
    }()
    
    private let contentsTextView: UITextView = {
        let view = UITextView()
        view.font = .mediumTitle15
        view.textColor = .placeholderText
        view.text = "일기의 내용을 적어주세요."
        
        return view
    }()
    
//    private let lineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .slate300
//        
//        return view
//    }()
//    
//    private let addImageButton: UIButton = {
//        var titleContainer = AttributeContainer()
//        titleContainer.font = UIFont.semiboldTitle14
//        
//        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(resource: .gallery)
//        configuration.attributedTitle = AttributedString("이미지 추가", attributes: titleContainer)
//        configuration.baseForegroundColor = .black
//        configuration.imagePadding = 8
//        configuration.titleAlignment = .leading
//        
//        let button = UIButton(configuration: configuration)
//        
//        return button
//    }()
//    
//    private let addVoteButton: UIButton = {
//        var titleContainer = AttributeContainer()
//        titleContainer.font = UIFont.semiboldTitle14
//        
//        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(resource: .voteCheckButton)
//        configuration.attributedTitle = AttributedString("투표하기", attributes: titleContainer)
//        configuration.baseForegroundColor = .black
//        configuration.imagePadding = 8
//        configuration.titleAlignment = .leading
//        
//        let button = UIButton(configuration: configuration)
//        
//        return button
//    }()
    
    required init(store: DiaryStore) {
        self.store = store
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTitleBar()
        configureTextField()
//        configureBottomBar()
        
        setUpBind()
        bind()
    }
    
    private func setUpBind() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.render(newState)
            }
            .store(in: &cancellables)
    }
    
    private func render(_ state: DiaryReducer.State) {
//        if state.isNewDiaryUploadSuccess == .success {
//            self.showToast(icon: .colorCheck, message: "일기가 저장되었어요.")
//        } else if state.isNewDiaryUploadSuccess == .failure {
//            self.showToast(icon: .colorXmark, message: "저장에 실패했어요.")
//        }
//        
//        if state.isDiaryUpdated == .success {
//            self.showToast(icon: .colorCheck, message: "일기가 저장되었어요.")
//        } else if state.isDiaryUpdated == .failure {
//            self.showToast(icon: .colorXmark, message: "저장에 실패했어요.")
//        }
        
        if let diary = state.diary {
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.content
            self.titleLabel.text = diary.formattedDate
        }
    }
    
    private func bind() {
        cancelButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.popPage)
            }
            .store(in: &cancellables)
        
        uploadButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self else {
                    return
                }
                let title = self.titleTextField.text ?? ""
                let content = self.contentsTextView.text ?? ""
                
                if let diary = store.state.diary {
                    store.dispatch(.updateDiary(id: diary.id, title: title, content: content))
                } else {
                    store.dispatch(.createNewDiary(title: title, content: content))
                }
            }
            .store(in: &cancellables)
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
        view.addSubview(contentsTextView)
        contentsTextView.delegate = self
        
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
//    private func configureBottomBar() {
//        view.addSubview(addImageButton)
//        view.addSubview(addVoteButton)
//        view.addSubview(lineView)
//        
//        addImageButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(8)
//            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
//        }
//        
//        addVoteButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().inset(8)
//            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.height.equalTo(0.5)
//            make.bottom.equalTo(addVoteButton.snp.top).offset(-8)
//            make.leading.trailing.equalToSuperview()
//        }
//    }
}

extension DiaryEditorViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .slate800
        }
    }
}

//#Preview {
//    let vc = DiaryEditorViewController()
//    
//    return vc
//}
