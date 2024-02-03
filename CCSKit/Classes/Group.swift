//
//  Group.swift
//  CCSKit
//
//  Created by dhoney96 on 1/10/24.
//

import UIKit

/**
 A container for a set of items that lays out the items along a path.
 Group can also used as item.
 */
public class Group: Item {
    final private let width: ComponentSize
    final private let height: ComponentSize
    
    /// An array of the items contained in the group.
    final private let subitems: [Item]
    
    /// The direction in which items are arranged.
    final private let arrangedDirection: ArrangedDirection
    
    /// The amount of space between the items in the group.
    private var interItemSpacing: CGFloat = 0

    public init(width: ComponentSize, height: ComponentSize, subitems: [Item], arrangedDirection: ArrangedDirection) {
        self.width = width
        self.height = height
        self.subitems = subitems
        self.arrangedDirection = arrangedDirection
        
        super.init(width: width, height: height)
    }
    
    /**
     Creates a NSCollectionLayoutGroup for constructing compositional layout.
     
     - Returns: NSCollectionLayoutGroup
     */
    internal func createLayoutGroup() -> NSCollectionLayoutGroup {
        var group: NSCollectionLayoutGroup! = nil
        let groupSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        
        switch arrangedDirection {
        case .vertical:
            group =  NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: subitems.map {
                if let group = $0 as? Group {
                    return group.createLayoutGroup()
                }
                
                return $0.createLayoutItem()
            })
        case .horizontal:
            group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: subitems.map {
                if let group = $0 as? Group {
                    return group.createLayoutGroup()
                }
                
                return $0.createLayoutItem()
            })
        }
        
        group.interItemSpacing = .fixed(interItemSpacing)
        
        return group
    }
}

extension Group {
    /// Set the amount of space between the items in the group.
    public func interItemSpacing(_ spacing: CGFloat) -> Self {
        self.interItemSpacing = spacing
        
        return self
    }
}
