//
//  TermsCheckViewController.swift
//  echog
//
//  Created by minsong kim on 2/26/25.
//

import Combine
import UIKit
import WebKit

class TermsCheckViewController: UIViewController {
    var store: MyPageStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldLargetitle17
        label.textColor = .black
        label.text = "개인정보 처리방침"
        
        return label
    }()
    
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.backward")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        configureView()
        loadWebView()
        
        bind()
    }
    
    private func bind() {
        backButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.popPage)
            }
            .store(in: &cancellables)
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
    
    private func configureView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
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
//    let vc = TermsCheckViewController()
//    
//    return vc
//}
