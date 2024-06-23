//
//  ViewController.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Section: Hashable {
        case freeApplications(AppData)
        case paidApplications(AppData)
    }

    struct Item: Hashable {
        let appInfo: AppInfo
        let id = UUID()
    }
    
    let viewModel = HomeViewModel()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        collectionView.delegate = self
    }
    
// MARK: - set up CollectionView layout
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCollectionViewCell")
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),
                                               heightDimension: .absolute(316))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item, item, item])
        group.interItemSpacing = .fixed(4)
        
        // 設定 header 的大小
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
// MARK: - set up CollectionView data source
    
    func updateDataSource() {
        guard let appDataModel = viewModel.fetchData() else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        // Add sections
        snapshot.appendSections([
            .freeApplications(appDataModel.freeApplications),
            .paidApplications(appDataModel.paidApplications)
        ])
        
        // Add items for each section
        let freeApplicationItems = appDataModel.freeApplications.applications.map { Item(appInfo: $0) }
        let paidApplicationItems = appDataModel.paidApplications.applications.map { Item(appInfo: $0) }
        
        snapshot.appendItems(freeApplicationItems, toSection: .freeApplications(appDataModel.freeApplications))
        snapshot.appendItems(paidApplicationItems, toSection: .paidApplications(appDataModel.paidApplications))
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AppCollectionViewCell.self)", for: indexPath) as! AppCollectionViewCell
            cell.configureCell(itemIdentifier.appInfo)
            cell.rankLabel.text = "\(indexPath.item + 1)"
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppSectionHeaderView.reuseIdentifier, for: indexPath) as! AppSectionHeaderView
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let title: String
                switch section {
                case .freeApplications(let appData):
                    title = appData.title
                case .paidApplications(let appData):
                    title = appData.title
                }
                headerView.configure(with: title)
                return headerView
            }
            return nil
        }
        updateDataSource()
    }

}

// MARK: - Extension: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        if let cell = collectionView.cellForItem(at: indexPath), let appInfo = viewModel.appInfo {
            let app: AppInfo
            if indexPath.section == 0 {
                app = appInfo.freeApplications.applications[indexPath.item]
            } else {
                app = appInfo.paidApplications.applications[indexPath.item]
            }
            detailView.appInfo = app
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
}
