//
//  ViewController.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var collectionView = UICollectionView()
    
    var appData: [AppData] = []
    var dataSource: UICollectionViewDiffableDataSource<AppData, AppInfo>!
    
    // 初始化 compositional layout
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(110),
                                              heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110),
                                               heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item, item, item])
        group.interItemSpacing = .fixed(8)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .gray
        createDataSource()
        collectionView.dataSource = dataSource
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<AppData, AppInfo>()
        appData.forEach { appData in
            snapshot.appendSections([appData])
            snapshot.appendItems(appData.applications)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AppCollectionViewCell.self)", for: indexPath) as! AppCollectionViewCell
            
            return cell
        })
        updateDataSource()
    }

}



