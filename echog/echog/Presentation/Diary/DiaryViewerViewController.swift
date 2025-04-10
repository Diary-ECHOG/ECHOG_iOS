//
//  DiaryViewerViewController.swift
//  echog
//
//  Created by minsong kim on 1/13/25.
//

import Combine
import UIKit
import SnapKit

class DiaryViewerViewController: UIViewController, PopUpProtocol, ToastProtocol {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    var store: DiaryStore
    private var cancellables = Set<AnyCancellable>()
    
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.backward")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let deletePopUp = PopUpView(message: "삭제한 일기는 복구할 수 없어요.\n정말 삭제할까요?", leftMessage: "취소", rightMessage: "삭제하기")
    
    private lazy var detailButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "ellipsis")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        button.menu = UIMenu(children: [
            (UIAction(title: "수정하기", image: UIImage(resource: .pencil)) { _ in
                self.store.dispatch(.goToEditDiary)
            }),
            (UIAction(title: "삭제하기", image: UIImage(resource: .delete), attributes: .destructive) { _ in
                self.showPopUp(view: self.deletePopUp)
            })
        ])
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    private let titleBarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .mediumTitle15
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldLargetitle17
        label.textColor = .slate800
        
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .slate600
        
        return label
    }()
    
//    private let divideLineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .slate25
//        
//        return view
//    }()
    
//    private let voteCheckButton = CellButton(title: "일기에서 생성된 투표보기", subTitle: "3", image: UIImage(systemName: "chevron.right"))
    
    init(store: DiaryStore) {
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
//        configureVoteCheckButton()
        
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
        if state.isDiaryDeleted == .failure {
            self.showToast(icon: .colorXmark, message: "삭제에 실패했어요")
        } else if state.isDiaryDeleted == .success {
            self.showToast(icon: .colorCheck, message: "삭제에 성공했어요")
        }
        
        if let diary = state.diary {
            titleBarLabel.text = diary.createdAt
            titleLabel.text = diary.title
            contentsLabel.text = diary.content
        }
        
        if state.isDiaryUpdated == .success, let diary = state.diary {
            titleBarLabel.text = diary.createdAt
            titleLabel.text = diary.title
            contentsLabel.text = diary.content
        }
    }
    
    private func bind() {
        backButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.popPage)
            }
            .store(in: &cancellables)
        
        deletePopUp.rightButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self, let diary = store.state.diary else {
                    return
                }
                
                dismissPopUp(view: deletePopUp)
                store.dispatch(.deleteDiary(id: diary.id))
            }
            .store(in: &cancellables)
        
        deletePopUp.leftButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self else {
                    return
                }
                
                dismissPopUp(view: deletePopUp)
            }
            .store(in: &cancellables)
    }
    
    private func configureTitleBar() {
        view.addSubview(titleBarLabel)
        view.addSubview(backButton)
        view.addSubview(detailButton)
        
        titleBarLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalTo(titleBarLabel.snp.centerY)
        }
        
        detailButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(titleBarLabel.snp.centerY)
        }
    }
    
    private func configureTextField() {
        view.addSubview(titleLabel)
        view.addSubview(contentsLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleBarLabel.snp.bottom).offset(30)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
    
//    private func configureVoteCheckButton() {
//        view.addSubview(divideLineView)
//        view.addSubview(voteCheckButton)
//        
//        voteCheckButton.snp.makeConstraints { make in
//            make.height.equalTo(50)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        divideLineView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(10)
//            make.bottom.equalTo(voteCheckButton.snp.top)
//        }
//    }
}

#Preview {
    let vc = DiaryViewerViewController(store: DiaryStore(reducer: DiaryReducer()))
    
    return vc
}
