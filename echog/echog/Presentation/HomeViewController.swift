//
//  HomeViewController.swift
//  echog
//
//  Created by minsong kim on 12/10/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private var diaryList: [DiaryDTO] = [DiaryDTO(id: 1, createDate: Date(), title: "Title", content: "Content..", userID: 1), DiaryDTO(id: 2, createDate: Date(), title: "Title", content: "Content..", userID: 2)]
    
    private let titleView: UIImageView = {
        let view = UIImageView(image: UIImage.logo)
        
        return view
    }()
    
    private let barVoteButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.semiboldTitle14
        
        var configuration = UIButton.Configuration.bordered()
        configuration.attributedTitle = AttributedString("투표보기", attributes: titleContainer)
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .slate800
        configuration.baseBackgroundColor = .white
        configuration.image = UIImage(resource: .voteCheckButton)
        configuration.cornerStyle = .capsule
        configuration.imagePadding = 4
        
        let button = UIButton(configuration: configuration)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 1.0
        button.layer.shadowColor = UIColor.slate100.cgColor
        button.layer.shadowOffset = .zero
        
        return button
    }()
    
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .slate300
        
        return button
    }()
    
    private let DiaryAddButton: UIButton = {
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
    private var dataSource: UICollectionViewDiffableDataSource<String, DiaryDTO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgoundView()
        configureNavigationBar()
        configureCollectionView()
        configureCollectionViewUI()
        configureAddButton()
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
        view.addSubview(barVoteButton)
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
        
        barVoteButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleView.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.trailing.equalTo(myPageButton.snp.leading).offset(-4)
        }
    }
    
    private func configureAddButton() {
        view.addSubview(DiaryAddButton)
        
        DiaryAddButton.snp.makeConstraints { make in
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
        dataSource = UICollectionViewDiffableDataSource<String, DiaryDTO>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCell.identifier, for: indexPath) as? DiaryCell else {
                return UICollectionViewCell()
            }
            
            cell.configureTexts(title: itemIdentifier.title, content: itemIdentifier.content, date: itemIdentifier.createDate.description)
            
            return cell
        }
        
        //headerView 등록 필요
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: UICollectionView.elementKindSectionHeader) {
            supplementaryView, elementKind, indexPath in
            supplementaryView.configureLabel(text: "10월")
        }
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
    }
    
    private func setSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, DiaryDTO>()
        snapshot.appendSections(["10월"])
        //스냅샷에 아이템 추가
        snapshot.appendItems(diaryList, toSection: "10월")
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

#Preview {
    let vc = HomeViewController()
    
    return vc
}
