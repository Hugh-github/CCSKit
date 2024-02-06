//
//  GridSection.swift
//  CCSKit
//
//  Created by dhoney96 on 2/1/24.
//

import UIKit

/// A container that combines set of row into distinct visual groupings.
public class GridSection: Section {
    /// Width of the row
    private let rowWidth: ComponentSize
    
    /// Height of the row
    private let rowHeight: ComponentSize
    
    /// Number of items in a row
    private let numberOfItemInRow: Int
    
    private var interItemSpacing: CGFloat = 0
    private var contentInsetsOfItem: NSDirectionalEdgeInsets = .zero
    private var supplementaryItemsOfItem: [NSCollectionLayoutSupplementaryItem] = []
    
    public init(rowWidth: ComponentSize, rowHeight: ComponentSize, numberOfItemInRow: Int) {
        self.rowWidth = rowWidth
        self.rowHeight = rowHeight
        self.numberOfItemInRow = numberOfItemInRow
        
        super.init(group: Group(width: .zero, height: .zero, subitems: [], arrangedDirection: .horizontal))
    }
    
    internal override func createLayoutSection() -> NSCollectionLayoutSection {
        let item = Item(width: rowWidth.resize(to: numberOfItemInRow), height: .fractionalHeight(1.0))
            .supplementaryItems(supplementaryItemsOfItem)
            .contentInsets(top: contentInsetsOfItem.top, leading: contentInsetsOfItem.leading, bottom: contentInsetsOfItem.bottom, trailing: contentInsetsOfItem.trailing)
        
        let group = Group(width: rowWidth, height: rowHeight, subitems: [item], arrangedDirection: .horizontal)
            .interItemSpacing(interItemSpacing)
        
        super.group = group
        
        return super.createLayoutSection()
    }
}

extension GridSection {
    /// Set the amount of space between the items in the row.
    public func interItemSpaicng(_ spacing: CGFloat) -> Self {
        self.interItemSpacing = spacing
        
        return self
    }
    
    /// Set the amount of space added around the content of the item to adjust its final size after its position is computed.
    public func contentInsetsOfItem(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        self.contentInsetsOfItem = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
        
        return self
    }
    
    /// Set the supplementary items attached to the item.
    public func supplementaryItemsOfItem(_ items: [SupplementaryView]) -> Self {
        self.supplementaryItemsOfItem = items.map { $0.createSupplementaryItem() }
        
        return self
    }
}
