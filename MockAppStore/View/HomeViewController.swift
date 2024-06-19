//
//  ViewController.swift
//  MockAppStore
//
//  Created by NY on 2024/6/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<AppDataModel, AppInfo>!
    
    // 初始化 compositional layout
    var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(330),
                                              heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(330),
                                               heightDimension: .absolute(316))
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
        viewModel.fetchData()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCollectionViewCell")
        createDataSource()
        collectionView.dataSource = dataSource
        setupCollectionView()
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<AppDataModel, AppInfo>()
        viewModel.appData.forEach { appDataModel in
            snapshot.appendSections([appDataModel])
            snapshot.appendItems(appDataModel.freeApplications.applications)
//            snapshot.appendItems(appDataModel.paidApplications.applications)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AppCollectionViewCell.self)", for: indexPath) as! AppCollectionViewCell
            let appInfo = self.viewModel.appData[indexPath.section].freeApplications.applications[indexPath.item]
            cell.configureCell(appInfo)
            cell.rankLabel.text = "\(indexPath.item + 1)"
            return cell
        })
        updateDataSource()
    }

}



