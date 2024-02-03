//
//  ViewController.swift
//  CCSKit
//
//  Created by Hugh-github on 01/08/2024.
//  Copyright (c) 2024 Hugh-github. All rights reserved.
//

import UIKit
import CCSKit

class ViewController: UIViewController {
    enum SectionList {
        case nested
        case grid
        case basic
    }
    
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<SectionList, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createSectionLayout())
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collectionView.register(TextBanner.self, forSupplementaryViewOfKind: "Banner", withReuseIdentifier: "NewBanner")
        collectionView.register(TextHeader.self, forSupplementaryViewOfKind: "TextHeader", withReuseIdentifier: "Header")
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionList, Int>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as? TextCell else { return nil }
            cell.textLabel.text = "\(itemIdentifier)"
            cell.contentView.backgroundColor = .yellow
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, index) -> UICollectionReusableView? in
            if elementKind == "Banner" {
                guard let banner = collectionView.dequeueReusableSupplementaryView(
                    ofKind: "Banner",
                    withReuseIdentifier: "NewBanner",
                    for: index
                ) as? TextBanner else {
                    return  nil
                }
                banner.isHidden = index.row % 5 != 0
                
                return banner
            } else if elementKind == "TextHeader" {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: "TextHeader",
                    withReuseIdentifier: "Header",
                    for: index
                ) as? TextHeader else {
                    return nil
                }
                header.textLabel.text = "Title"
                
                return header
            }
            
            return nil
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionList, Int>()
        snapshot.appendSections([.nested, .grid, .basic])
        snapshot.appendItems(Array(0..<15), toSection: .nested)
        snapshot.appendItems(Array(100..<109), toSection: .grid)
        snapshot.appendItems(Array(1000..<1005), toSection: .basic)
        dataSource.apply(snapshot)
    }
    
    func createSectionLayout() -> UICollectionViewLayout {
        let sectionHeader = SupplementaryView(width: .fractionalWidth(1.0), height: .fractionalHeight(0.05), elementKind: "TextHeader")
            .topItem()
        
        let sectionBackground = DecorationItem(elementKind: "SectionBackground")
        
        let newBanner = SupplementaryView(width: .fractionalWidth(0.3), height: .fractionalHeight(0.2), elementKind: "Banner")
            .topLeadingItem(offset: .init(x: 7, y: 5))
        
        let firstSection = NestedGroupsSection(groupWidth: .fractionalWidth(1.0), groupHeight: .fractionalHeight(0.3), arrangedDirection: .vertical, numberOfItemsInInnerGroups: [1, 2, 2])
            .innerGroupsFractionalSize([0.5, 0.25, 0.25])
            .interInnerGroupItemSpacing([0, 5, 5])
            .interInnerGroupSpacing(5)
            .interGroupSpacing(10)
            .contentInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            .scrollingBehavior(.continuous)
            .boundarySupplementaryItems([sectionHeader])
            .decorationItems([sectionBackground])
        
        let secondSection = GridSection(rowWidth: .fractionalWidth(1.0), rowHeight: .fractionalHeight(0.1), numberOfItemInRow: 3)
            .scrollingBehavior(.continuous)
            .supplementaryItemsOfItem([newBanner])
            .interItemSpaicng(10)
            .interGroupSpacing(10)
            .visibleItemInvalidationHandler { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.7
                    let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        
        let item = Item(width: .fixed(120), height: .fixed(30))
        let group = Group(width: .fixed(120), height: .fixed(150), subitems: [item], arrangedDirection: .vertical)
        let thirdSection = Section(group: group)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(sections: [firstSection, secondSection, thirdSection], configuration: configuration)
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "SectionBackground")
        
        return layout
    }
}

class TextCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

class TextBanner: UICollectionReusableView {
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "New"
        label.textColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(backgroundView)
        backgroundView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
}

class TextHeader: UICollectionReusableView {
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.textColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
}

class SectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


