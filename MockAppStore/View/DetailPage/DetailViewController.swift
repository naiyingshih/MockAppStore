//
//  DetailViewController.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case banner = 0
        case detail
        case version
        case preview
    }
    
    struct Item: Hashable {
        let id = UUID()
        let section: Section
        let appInfo: AppInfo
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        createDataSource()
    }
    
    // MARK: - Layout
    
    func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(UINib(nibName: "DetailInfoCell", bundle: nil), forCellWithReuseIdentifier: "DetailInfoCell")
        collectionView.register(UINib(nibName: "VersionCell", bundle: nil), forCellWithReuseIdentifier: "VersionCell")
        collectionView.register(PreViewCell.self, forCellWithReuseIdentifier: PreViewCell.reuseIdentifier)
        collectionView.register(AppSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppSectionHeaderView.reuseIdentifier)
        self.view.addSubview(collectionView)
     
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.bannerCellSection()
            case 1:
                return self.detailInfoCellSection()
            case 2:
                return self.versionCellSection()
            default:
                return self.preViewCellSection()
            }
        }
        return layout
    }

    func bannerCellSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func detailInfoCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32)
                                               , heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(5))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func versionCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func preViewCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    // MARK: - Data Source
    func updateDataSource(for appInfo: AppInfo) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        // Add sections
        snapshot.appendSections(Section.allCases)
        
        // Create an array of items to add to each section
        let items = Section.allCases.map { Item(section: $0, appInfo: appInfo) }
        
        // Loop through all sections and add items
        for section in Section.allCases {
            snapshot.appendItems(items.filter { $0.section == section }, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, _ in
            
            guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
            let appInfo = self.viewModel.appInfo
            
            switch section {
            case .banner:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
                cell.configureCell(appInfo)
                return cell
            case .detail:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoCell
                let index = self.viewModel.index
                let detailModel = self.viewModel.loadData(appInfo, index: index)[indexPath.item]
                cell.configureCell(detailModel)
                return cell
            case .version:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VersionCell", for: indexPath) as! VersionCell
                cell.configureCell(appInfo)
                return cell
            case .preview:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreViewCell", for: indexPath) as! PreViewCell
                let images = appInfo.screenshotUrls[indexPath.item]
                cell.configureCell(images)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppSectionHeaderView.reuseIdentifier, for: indexPath) as! AppSectionHeaderView
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                var title: String
                var version = ""
                switch section {
                case .version:
                    title = "新功能"
                    version = "版本紀錄"
                case .preview:
                    title = "預覽"
                default:
                    title = ""
                }
                headerView.configure(with: title, version: version)
                return headerView
            }
            return nil
        }
        updateDataSource(for: viewModel.appInfo)
    }
}
