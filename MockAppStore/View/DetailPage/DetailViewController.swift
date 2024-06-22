//
//  DetailViewController.swift
//  MockAppStore
//
//  Created by NY on 2024/6/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
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
    
    
    
}
