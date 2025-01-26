//
//  DiaryViewerViewController.swift
//  echog
//
//  Created by minsong kim on 1/13/25.
//

import UIKit
import SnapKit

class DiaryViewerViewController: UIViewController, PopUpProtocol {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
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
                print("수정하기")
            }),
            (UIAction(title: "삭제하기", image: UIImage(resource: .delete)) { _ in
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
    
    private let divideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .slate25
        
        return view
    }()
    
    private let voteCheckButton = CellButton(title: "일기에서 생성된 투표보기", subTitle: "3", image: UIImage(systemName: "chevron.right"))
    
    init(date: String, title: String, content: String) {
        titleBarLabel.text = date
        titleLabel.text = title
        contentsLabel.text = content
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTitleBar()
        configureTextField()
        configureVoteCheckButton()
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
    
    private func configureVoteCheckButton() {
        view.addSubview(divideLineView)
        view.addSubview(voteCheckButton)
        
        voteCheckButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        divideLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
            make.bottom.equalTo(voteCheckButton.snp.top)
        }
    }
}

#Preview {
    let vc = DiaryViewerViewController(date: "01월 10일 금요일", title: "제목입니다", content: "내용입니다.")
    
    return vc
}
