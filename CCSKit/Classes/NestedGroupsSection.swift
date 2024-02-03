//
//  NestedGroupSection.swift
//  CCSKit
//
//  Created by dhoney96 on 2/1/24.
//

import UIKit

// Nested Group example(nested axis == horizontal)
//   +-----------------------------------------------------+
//   | +---------------------------------+  +-----------+  |
//   | |                                 |  |           |  |
//   | |                                 |  |           |  |
//   | |                                 |  |     1     |  |
//   | |                                 |  |           |  |
//   | |                                 |  |           |  |
//   | |                                 |  +-----------+  |
//   | |               0                 |                 |
//   | |                                 |  +-----------+  |
//   | |                                 |  |           |  |
//   | |                                 |  |           |  |
//   | |                                 |  |     2     |  |
//   | |                                 |  |           |  |
//   | |                                 |  |           |  |
//   | +---------------------------------+  +-----------+  |
//   +-----------------------------------------------------+

public class NestedGroupsSection: Section {
    /// Width of the nested group.
    private let groupWidth: ComponentSize
    
    /// Height of the nested group.
    private let groupHeight: ComponentSize
    
    /// The direction in which inner group are arranged.
    private let arrangedDirection: ArrangedDirection
    
    /// Number of items in inner Groups.
    private let numberOfItemsInInnerGroups: [Int]
    
    private var interInnerGroupSpacing: CGFloat = 0
    private var contentInsetsOfItem: NSDirectionalEdgeInsets = .zero
    private var interInnerGroupItemSpacing: [CGFloat] = []
    private var innerGroupsFractionalSize: [CGFloat] = []
    private var supplementaryItemsOfItem: [NSCollectionLayoutSupplementaryItem] = []
    
    public init(groupWidth: ComponentSize, groupHeight: ComponentSize, arrangedDirection: ArrangedDirection, numberOfItemsInInnerGroups: [Int]) {
        self.groupWidth = groupWidth
        self.groupHeight = groupHeight
        self.arrangedDirection = arrangedDirection
        self.numberOfItemsInInnerGroups = numberOfItemsInInnerGroups
        
        super.init(group: Group(width: .zero, height: .zero, subitems: [], arrangedDirection: .horizontal))
    }
    
    internal override func createLayoutSection() -> NSCollectionLayoutSection {
        var group: Group! = nil
        
        switch arrangedDirection {
        case .vertical:
            group = createGroupOnVertical()
                .interItemSpacing(interInnerGroupSpacing)
        case .horizontal:
            group = createGroupOnHorizontal()
                .interItemSpacing(interInnerGroupSpacing)
        }
        
        super.group = group
        
        return super.createLayoutSection()
    }
}

extension NestedGroupsSection {
    /// Set the amount of space between the items in the inner group.
    public func interInnerGroupItemSpacing(_ spacing: [CGFloat]) -> Self {
        self.interInnerGroupItemSpacing = spacing
        
        return self
    }
    
    /// Set the amount of space between the groups in the nested group.
    public func interInnerGroupSpacing(_ spacing: CGFloat) -> Self {
        self.interInnerGroupSpacing = spacing
        
        return self
    }
    
    /// Set the amount of space added around the content of the item to adjust its final size after its position is computed.
    public func contentInsetsOfItem(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        self.contentInsetsOfItem = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
        
        return self
    }
    
    /**
     Set the fractional size the inner groups in the nested group.
     
     Use this method to set different size ratio each inner group. The sum of the array must be 1. The number of array element must equal `numberOfItemsInInnerGroups`. Default is all inner groups have the same size ratio.
     - Parameter fractionalSizes: The size ratio list of each inner group in the nested group.
     */
    public func innerGroupsFractionalSize(_ fractionalSizes: [CGFloat]) -> Self {
        if fractionalSizes.count == numberOfItemsInInnerGroups.count {
            self.innerGroupsFractionalSize = fractionalSizes
        } else if fractionalSizes.count < numberOfItemsInInnerGroups.count {
            self.innerGroupsFractionalSize = fractionalSizes
            
            while innerGroupsFractionalSize.count != numberOfItemsInInnerGroups.count {
                self.innerGroupsFractionalSize.append(0.01)
            }
        }
        
        return self
    }
    
    /// Set the supplementary items attached to the item.
    public func supplementaryItemsOfItem(_ items: [SupplementaryView]) -> Self {
        self.supplementaryItemsOfItem = items.map { $0.createSupplementaryItem() }
        
        return self
    }
}

extension NestedGroupsSection {
    /// Create nested group when nested axis is vertical.
    private func createGroupOnVertical() -> Group {
        var items = [Item]()
        
        for (index, count) in numberOfItemsInInnerGroups.enumerated() {
            let item = Item(width: groupWidth.resize(to: count), height: .fractionalHeight(1.0))
                .supplementaryItems(supplementaryItemsOfItem)
                .contentInsets(top: contentInsetsOfItem.top, leading: contentInsetsOfItem.leading, bottom: contentInsetsOfItem.bottom, trailing: contentInsetsOfItem.trailing)
            var groupedItem: Group! = nil
            
            if innerGroupsFractionalSize.isEmpty {
                groupedItem = Group(width: .fractionalWidth(1.0), height: groupHeight.resize(to: numberOfItemsInInnerGroups.count), subitems: [item], arrangedDirection: .horizontal)
                    .interItemSpacing(interInnerGroupItemSpacing[index])
            } else {
                groupedItem = Group(width: .fractionalWidth(1.0), height: groupHeight.resize(to: innerGroupsFractionalSize[index]), subitems: [item], arrangedDirection: .horizontal)
                    .interItemSpacing(interInnerGroupItemSpacing[index])
            }
            
            items.append(groupedItem)
        }
        
        return Group(width: groupWidth, height: groupHeight, subitems: items, arrangedDirection: .vertical)
    }
    
    /// Create nested group when nested axis is horizontal.
    private func createGroupOnHorizontal() -> Group {
        var items = [Item]()
        
        for (index, count) in numberOfItemsInInnerGroups.enumerated() {
            let item = Item(width: .fractionalWidth(1.0), height: groupHeight.resize(to: count))
                .supplementaryItems(supplementaryItemsOfItem)
                .contentInsets(top: contentInsetsOfItem.top, leading: contentInsetsOfItem.leading, bottom: contentInsetsOfItem.bottom, trailing: contentInsetsOfItem.trailing)
            var groupedItem: Group! = nil
            
            if innerGroupsFractionalSize.isEmpty {
                groupedItem = Group(width: groupWidth.resize(to: numberOfItemsInInnerGroups.count), height: .fractionalHeight(1.0), subitems: [item], arrangedDirection: .vertical)
                    .interItemSpacing(interInnerGroupItemSpacing[index])
            } else {
                groupedItem = Group(width: groupWidth.resize(to: innerGroupsFractionalSize[index]), height: .fractionalHeight(1.0), subitems: [item], arrangedDirection: .vertical)
                    .interItemSpacing(interInnerGroupItemSpacing[index])
            }
            
            items.append(groupedItem)
        }
        
        return Group(width: groupWidth, height: groupHeight, subitems: items, arrangedDirection: .horizontal)
    }
}
