//
//  VoteListViewController.swift
//  echog
//
//  Created by minsong kim on 2/7/25.
//

import UIKit
import SnapKit

class VoteListViewController: UIViewController {
    private var diaryList: [VoteDTO] = [VoteDTO(id: "1", category: "직장", title: "이게뭐죠", content1: "1번", content2: "2번", content3: "3번", content4: "4번", content5: "5벙", content1Count: 1, content2Count: 2, content3Count: 3, content4Count: 4, content5Count: 5, endTime: "2020년 2월 15일", result: "으아아아")]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투표"
        label.font = .semiboldSubheadline22
        label.textColor = .slate800
        
        return label
    }()
    
    private let barDiaryButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.semiboldTitle14
        
        var configuration = UIButton.Configuration.bordered()
        configuration.attributedTitle = AttributedString("일기보기", attributes: titleContainer)
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .slate800
        configuration.baseBackgroundColor = .white
        configuration.image = UIImage(resource: .book)
        configuration.cornerStyle = .capsule
        configuration.imagePadding = 4
        
        let button = UIButton(configuration: configuration)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 1.0
        button.layer.shadowColor = UIColor.slate100.cgColor
        button.layer.shadowOffset = .zero
        
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .search), for: .normal)
        button.tintColor = .slate800
        
        return button
    }()
    
    private lazy var categoryButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.mediumTitle14
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .slate500
        configuration.attributedTitle = AttributedString("전체보기", attributes: titleContainer)
        configuration.cornerStyle = .medium
        configuration.background.strokeColor = .border
        configuration.background.strokeWidth = 1
        
        let button = UIButton(configuration: configuration)
        button.titleLabel?.font = .mediumTitle13
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    let dropdownImage: UIImageView = {
        let image = UIImage(systemName: "arrowtriangle.down.fill")
        let view = UIImageView(image: image)
        view.tintColor = .slate800
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let totalCountLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle13
        label.text = "총 100개"
        label.textColor = .slate800
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var flowLayout = self.createFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    private var dataSource: UICollectionViewDiffableDataSource<Int, VoteDTO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgoundView()
        configureNavigationBar()
        configureCollectionView()
        configureCategoryButton()
        configureMiddleBar()
        configureCollectionViewUI()
    }
    
    //배경 설정
    private func configureBackgoundView() {
        let backgoundView = UIImageView(image: UIImage(resource: .background2))
        
        view.addSubview(backgoundView)
        
        backgoundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    //상단바 위치 잡기
    private func configureNavigationBar() {
        view.addSubview(titleLabel)
        view.addSubview(barDiaryButton)
        view.addSubview(searchButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(32)
            make.width.equalTo(90)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.width.equalTo(32)
        }
        
        barDiaryButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.trailing.equalTo(searchButton.snp.leading).offset(-4)
        }
    }
    
    //카테고리 버튼 설정
    private func configureCategoryButton() {
        view.addSubview(categoryButton)
        view.addSubview(dropdownImage)
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(searchButton.snp.trailing)
            make.height.equalTo(48)
        }
        
        dropdownImage.snp.makeConstraints { make in
            make.trailing.equalTo(categoryButton.snp.trailing).inset(16)
            make.centerY.equalTo(categoryButton.snp.centerY)
            make.height.width.equalTo(12)
        }
    }
    
    //컬렉션뷰 상단바 설정
    private func configureMiddleBar() {
        view.addSubview(totalCountLabel)
        
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(categoryButton)
        }
    }
    
    //컬렉션뷰 레이아웃 생성
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        
        layout.itemSize = CGSize(width: width - 52, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 18, bottom: 16, right: 18)
        
        return layout
    }
    
    //컬렉션뷰 위치 잡기
    private func configureCollectionViewUI() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.top.equalTo(totalCountLabel.snp.bottom).offset(4)
        }
    }
    
    //컬렉션뷰 등록하기
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(VoteCell.self, forCellWithReuseIdentifier: VoteCell.identifier)
        
        setDataSource()
        setSnapshot()
    }
     
    //Diffable DataSource 세팅
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, VoteDTO>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCell.identifier, for: indexPath) as? VoteCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCells(title: itemIdentifier.title, contents: itemIdentifier.result, date: itemIdentifier.endTime, voteNumber: itemIdentifier.totalCount)
            
            return cell
        }
    }
    
    private func setSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, VoteDTO>()
        snapshot.appendSections([0])
        //스냅샷에 아이템 추가
        snapshot.appendItems(diaryList, toSection: 0)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension VoteListViewController: UICollectionViewDelegate {
}

#Preview {
    let vc = VoteListViewController()
    
    return vc
}
