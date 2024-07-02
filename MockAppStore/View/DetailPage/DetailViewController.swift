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
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    var appInfo: AppInfo
    
    init(appInfo: AppInfo) {
        self.appInfo = appInfo
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

    func bannerCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func detailInfoCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75)
                                               , heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func versionCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func preViewCellSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75)
                                               , heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    // MARK: - Data Source
    func updateDataSource(for appInfo: AppInfo) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        // Add sections
        snapshot.appendSections(Section.allCases)
        
        // Add items for each section
        snapshot.appendItems([appInfo], toSection: .banner)
        snapshot.appendItems([appInfo], toSection: .detail)
        snapshot.appendItems([appInfo], toSection: .version)
        snapshot.appendItems([appInfo], toSection: .preview)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
            self.updateDataSource(for: self.appInfo)
            
            switch section {
            case .banner:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
                if let appInfo = itemIdentifier as? AppInfo {
                    cell.configureCell(appInfo)
                }
                return cell
            case .detail:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoCell
                if let appInfo = itemIdentifier as? AppInfo {
                    //                    cell.configureCell(appInfo)
                }
                return cell
            case .version:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VersionCell", for: indexPath) as! VersionCell
                if let appInfo = itemIdentifier as? AppInfo {
                    //                    cell.configureCell(appInfo)
                }
                return cell
            case .preview:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreViewCell", for: indexPath) as! PreViewCell
                if let appInfo = itemIdentifier as? AppInfo {
                    //                    cell.configureCell(appInfo)
                }
                return cell
            }
        }
    }
}
