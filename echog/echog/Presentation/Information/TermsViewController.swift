//
//  TermsViewController.swift
//  echog
//
//  Created by minsong kim on 1/31/25.
//

import Combine
import UIKit
import SnapKit
import WebKit

class TermsViewController: UIViewController, ToastProtocol {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    var store: InformationStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약관 동의가 필요해요."
        label.font = .semiboldSubheadline22
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let nextButton = MainButton(title: "확인", isEnabled: true)
    
    required init(store: InformationStore) {
        self.store = store
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTitleLabel()
        configureWebView()
        loadWebView()
        
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
    
    private func render(_ state: InformationReducer.State) {
        if state.isRegisterSuccess == .success {
            self.dismiss(animated: true)
        } else if state.isRegisterSuccess == .failure {
            self.showToast(icon: .colorXmark, message: "다시 시도해주세요")
        }
    }
    
    private func bind() {
        nextButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self = self else { return }
                print(store.state)
                self.store.dispatch(.goToNextPage(email: self.store.state.email, password: self.store.state.password ?? ""))
            }
            .store(in: &cancellables)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(nextButton.snp.top).inset(8)
        }
    }
    
    private func loadWebView() {
        //웹 링크 띄우기
        let link = "https://marchens.notion.site/echog-terms?pvs=4"
        guard let url = URL(string: link) else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

//#Preview {
//    let vc = TermsViewController()
//    
//    return vc
//}
