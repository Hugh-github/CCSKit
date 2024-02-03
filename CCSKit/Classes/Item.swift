//
//  Item.swift
//  CCSKit
//
//  Created by dhoney96 on 1/10/24.
//

import UIKit

/**
 The most basic component of a collection view’s layout.
 */
public class Item {
    final private let width: ComponentSize
    final private let height: ComponentSize
    
    private(set) var contentInsets: NSDirectionalEdgeInsets = .zero
    private var supplementaryItems: [NSCollectionLayoutSupplementaryItem] = []
    
    public init(width: ComponentSize, height: ComponentSize) {
        self.width = width
        self.height = height
    }
    
    /**
     Creates a NSCollectionLayoutItem for constructing compositional layout.
     
     - Returns: NSCollectionLayoutItem
     */
    final internal func createLayoutItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        var item: NSCollectionLayoutItem! = nil
        
        if supplementaryItems.isEmpty {
            item = NSCollectionLayoutItem(layoutSize: itemSize)
        } else {
            item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: supplementaryItems)
        }
        
        item.contentInsets = contentInsets
        
        return item
    }
}

extension Item {
    /// Set the amount of space added around the content of the item to adjust its final size after its position is computed.
    final public func contentInsets(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        self.contentInsets = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
        
        return self
    }
    
    /**
     Append supplementary items to be attached to the item.
     
     - Parameters:
        - item: Supplementary items to be attached to the item.
        - edge: The edges of the item an anchor is attached to.
        - offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    final public func appendSupplementaryItem(_ item: SupplementaryView) -> Self {
        self.supplementaryItems.append(item.createSupplementaryItem())
        
        return self
    }
}

internal extension Item {
    /// Set the supplementary items attached to the item.
    final func supplementaryItems(_ items: [NSCollectionLayoutSupplementaryItem]) -> Self {
        self.supplementaryItems = items
        
        return self
    }
}
