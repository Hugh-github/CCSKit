//
//  SupplementaryView.swift
//  CCSKit
//
//  Created by dhoney96 on 2/1/24.
//

import UIKit

/// An object used to add an extra visual decoration to an item in a collection view.
public class SupplementaryView: Item {
    final private let width: ComponentSize
    final private let height: ComponentSize
    
    /**
     A string that identifies the type of supplementary item.
     
     It should be the same as the reuse identifier used when registering supplementary view in collection view.
     */
    final private let elementKind: String
    
    private var edges: NSDirectionalRectEdge = []
    private var alignment: NSRectAlignment = .none
    private var offset: CGPoint = .zero
    
    public init(width: ComponentSize, height: ComponentSize, elementKind: String) {
        self.width = width
        self.height = height
        self.elementKind = elementKind
        
        super.init(width: width, height: height)
    }
    
    /**
     Aligns view position to the top edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func topItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.top]
        self.alignment = .top
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the top and leading edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func topLeadingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.top, .leading]
        self.alignment = .topLeading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the top and trailing edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func topTrailingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.top, .trailing]
        self.alignment = .topTrailing
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the leading edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func leadingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.leading]
        self.alignment = .leading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the trailing edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func trailingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.trailing]
        self.alignment = .trailing
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func bottomItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.bottom]
        self.alignment = .bottom
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom and leading edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func bottomLeadingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.bottom, .leading]
        self.alignment = .bottomLeading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom and trailing edge.
     
     - Parameter offset: The floating-point absolute value of the anchor's offset from the item it's attached to.
     */
    public func bottomTrailingItem(offset: CGPoint = .zero) -> Self {
        self.edges = [.bottom, .trailing]
        self.alignment = .bottomLeading
        self.offset = offset
        
        return self
    }
}

internal extension SupplementaryView {
    /**
     Create the NSCollectionLayoutSupplementaryItem required for the item.
     
     - Returns: NSCollectionLayoutSupplementaryItem
     */
    func createSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        let anchor = NSCollectionLayoutAnchor(edges: edges, absoluteOffset: offset)
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: itemSize, elementKind: elementKind, containerAnchor: anchor)
        supplementaryItem.contentInsets = super.contentInsets
        
        return supplementaryItem
    }
    
    /**
     Create the NSCollectionLayoutBoundarySupplementaryItem required for the Section.
     
     - Returns: NSCollectionLayoutBoundarySupplementaryItem
     */
    func createBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize, elementKind: elementKind, alignment: alignment)
        boundarySupplementaryItem.contentInsets = super.contentInsets
        
        return boundarySupplementaryItem
    }
}
