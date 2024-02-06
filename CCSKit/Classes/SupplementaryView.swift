//
//  SupplementaryView.swift
//  CCSKit
//
//  Created by dhoney96 on 2/1/24.
//

import UIKit

// MARK: 위치에 따른 Item을 생성하는 코드 설명 수정해야 한다.

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
    private var offset: Offset = .zero
    
    public init(width: ComponentSize, height: ComponentSize, elementKind: String) {
        self.width = width
        self.height = height
        self.elementKind = elementKind
        
        super.init(width: width, height: height)
    }
    
    /**
     Aligns view position to the top edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func topItem(offset: Offset = .zero) -> Self {
        self.edges = [.top]
        self.alignment = .top
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the top and leading edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func topLeadingItem(offset: Offset = .zero) -> Self {
        self.edges = [.top, .leading]
        self.alignment = .topLeading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the top and trailing edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func topTrailingItem(offset: Offset = .zero) -> Self {
        self.edges = [.top, .trailing]
        self.alignment = .topTrailing
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the leading edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func leadingItem(offset: Offset = .zero) -> Self {
        self.edges = [.leading]
        self.alignment = .leading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the trailing edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func trailingItem(offset: Offset = .zero) -> Self {
        self.edges = [.trailing]
        self.alignment = .trailing
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func bottomItem(offset: Offset = .zero) -> Self {
        self.edges = [.bottom]
        self.alignment = .bottom
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom and leading edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func bottomLeadingItem(offset: Offset = .zero) -> Self {
        self.edges = [.bottom, .leading]
        self.alignment = .bottomLeading
        self.offset = offset
        
        return self
    }
    
    /**
     Aligns view position to the bottom and trailing edge.
     
     - Parameter offset: The floating-point value of the anchor's offset from the item it's attached to.
     */
    public func bottomTrailingItem(offset: Offset = .zero) -> Self {
        self.edges = [.bottom, .trailing]
        self.alignment = .bottomLeading
        self.offset = offset
        
        return self
    }
}

internal extension SupplementaryView {
    /**
     Create the NSCollectionLayoutSupplementaryItem of the item.
     
     - Returns: NSCollectionLayoutSupplementaryItem
     */
    func createSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        let anchor = createLayoutAnchor()
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: itemSize, elementKind: elementKind, containerAnchor: anchor)
        supplementaryItem.contentInsets = super.contentInsets
        
        return supplementaryItem
    }
    
    /**
     Create the NSCollectionLayoutBoundarySupplementaryItem of the Section.
     
     - Returns: NSCollectionLayoutBoundarySupplementaryItem
     */
    func createBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width.dimenssion, heightDimension: height.dimenssion)
        let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize, elementKind: elementKind, alignment: alignment)
        boundarySupplementaryItem.contentInsets = super.contentInsets
        
        return boundarySupplementaryItem
    }
    
    /**
     Create the NSCollectionLayoutAnchor of the supplementary view.
     
     - Returns: NSCollectionLayoutAnchor
     */
    func createLayoutAnchor() -> NSCollectionLayoutAnchor {
        switch offset {
        case .absoulte(let point):
            return NSCollectionLayoutAnchor(edges: edges, absoluteOffset: point)
        case .fractional(let point):
            return NSCollectionLayoutAnchor(edges: edges, fractionalOffset: point)
        case .zero:
            return NSCollectionLayoutAnchor(edges: edges, absoluteOffset: .zero)
        }
    }
}
