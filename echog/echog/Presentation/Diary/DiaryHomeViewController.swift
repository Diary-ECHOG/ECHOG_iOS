//
//  DiaryHomeViewController.swift
//  echog
//
//  Created by minsong kim on 12/10/24.
//

import Combine
import UIKit
import SnapKit
import NetworkFeatureKit

class DiaryHomeViewController: UIViewController, View {
    var store: DiaryStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleView: UIImageView = {
        let view = UIImageView(image: UIImage.logo)
        
        return view
    }()
    
//    private let barVoteButton: UIButton = {
//        var titleContainer = AttributeContainer()
//        titleContainer.font = UIFont.semiboldTitle14
//        
//        var configuration = UIButton.Configuration.bordered()
//        configuration.attributedTitle = AttributedString("투표보기", attributes: titleContainer)
//        configuration.titleAlignment = .trailing
//        configuration.baseForegroundColor = .slate800
//        configuration.baseBackgroundColor = .white
//        configuration.image = UIImage(resource: .voteCheckButton)
//        configuration.cornerStyle = .capsule
//        configuration.imagePadding = 4
//        
//        let button = UIButton(configuration: configuration)
//        button.layer.shadowOpacity = 1.0
//        button.layer.shadowRadius = 1.0
//        button.layer.shadowColor = UIColor.slate100.cgColor
//        button.layer.shadowOffset = .zero
//        
//        return button
//    }()
    
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .slate300
        
        return button
    }()
    
    private let diaryAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus")?.resize(newWidth: 25), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.slate100.cgColor
        button.layer.shadowOffset = .zero
        
        return button
    }()
    
    private lazy var flowLayout = self.createFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    private var dataSource: UICollectionViewDiffableDataSource<String, DiaryContent>?
    
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
        
        configureBackgoundView()
        configureNavigationBar()
        configureCollectionView()
        configureCollectionViewUI()
        configureAddButton()
        
        setUpBind()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if store.state.diaryList.isEmpty {
            store.dispatch(.presentDiaryList(page: 0))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        flowLayout.itemSize = CGSize(width: width - 52, height: 100)
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
        if state.shouldLoadSnapshot {
            self.setSnapshot()
        }
    }
    
    private func bind() {
//        barVoteButton.publisher(for: .touchUpInside)
//            .sink { [weak self] in
//                self?.store.dispatch(.goToVoteListPage)
//            }
//            .store(in: &cancellables)
        
        myPageButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.goToMyPage)
            }
            .store(in: &cancellables)
        
        diaryAddButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.goToCreateNewDiary)
            }
            .store(in: &cancellables)
    }
    
    private func configureBackgoundView() {
        let backgoundView = UIImageView(image: UIImage(resource: .background2))
        
        view.addSubview(backgoundView)
        
        backgoundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        view.addSubview(titleView)
//        view.addSubview(barVoteButton)
        view.addSubview(myPageButton)
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(32)
            make.width.equalTo(90)
        }
        
        myPageButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(titleView.snp.centerY)
            make.height.width.equalTo(32)
        }
        
//        barVoteButton.snp.makeConstraints { make in
//            make.centerY.equalTo(titleView.snp.centerY)
//            make.height.equalTo(30)
//            make.width.equalTo(100)
//            make.trailing.equalTo(myPageButton.snp.leading).offset(-4)
//        }
    }
    
    private func configureAddButton() {
        view.addSubview(diaryAddButton)
        
        diaryAddButton.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.bottom.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        
        layout.itemSize = CGSize(width: width - 52, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 18, bottom: 16, right: 18)
        layout.headerReferenceSize = CGSize(width: 30, height: 24)
        
        return layout
    }
    
    //컬렉션뷰 위치 잡기
    private func configureCollectionViewUI() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.top.equalTo(titleView.snp.bottom).offset(16)
        }
    }
    
    //컬렉션뷰 등록하기
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(DiaryCell.self, forCellWithReuseIdentifier: DiaryCell.identifier)
        
        setDataSource()
        setSnapshot()
    }
     
    //Diffable DataSource 세팅
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, DiaryContent>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCell.identifier, for: indexPath) as? DiaryCell else {
                return UICollectionViewCell()
            }
            
            cell.configureTexts(title: itemIdentifier.title, content: itemIdentifier.content, date: itemIdentifier.formattedDate)
            
            return cell
        }
        
        //headerView 등록 필요
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            let sectionTitle = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section] ?? ""
            supplementaryView.configureLabel(text: sectionTitle)
        }
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
    }
    
    private func setSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, DiaryContent>()
        
        let sortedSections = store.state.diaryList.keys.sorted { s1, s2 in
            if s1 == "오늘" { return true }
            if s2 == "오늘" { return false }
            if s1 == "어제" { return true }
            if s2 == "어제" { return false }
            
            // "10월"과 같이 월 정보를 비교 (문자열에서 "월" 제거)
            let m1 = Int(s1.replacingOccurrences(of: "월", with: "")) ?? 0
            let m2 = Int(s2.replacingOccurrences(of: "월", with: "")) ?? 0
            return m1 > m2
        }
        
        snapshot.appendSections(sortedSections)
        
        for section in sortedSections {
            if let items = store.state.diaryList[section], items.isEmpty == false {
                snapshot.appendItems(items, toSection: section)
            }
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateSnapshot() {
        
    }
}

extension DiaryHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let diary = dataSource?.itemIdentifier(for: indexPath) {
            store.dispatch(.goToDiaryViewer(id: diary.id, title: diary.title, content: diary.content, date: diary.formattedDate))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        // threshold는 미리 로드할 시점을 조정하기 위한 값입니다.
        let threshold: CGFloat = 20
        
        if offsetY > contentHeight - frameHeight - threshold, store.state.totalPage >= store.state.currentPage + 1 {
            // 스크롤이 바닥에 근접했을 때 호출
            store.dispatch(.scrollToBottom(store.state.currentPage + 1))
        }
    }
}

//#Preview {
//    let vc = HomeViewController()
//    
//    return vc
//}
