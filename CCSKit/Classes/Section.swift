//
//  Section.swift
//  CCSKit
//
//  Created by dhoney96 on 1/10/24.
//

import UIKit

/// A container that combines a set of nested group into distinct visual groupings.
public class Section {
    /// The specified group for creating section.
    internal var group: Group
    
    private var contentInsets: NSDirectionalEdgeInsets = .zero
    private var interGroupSpacing: CGFloat = 0
    
    private var sectionBoundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
    private var decorationItems: [NSCollectionLayoutDecorationItem] = []
    
    private var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
    
    private var visibleItemInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler = { _, _, _ in }
    
    public init(group: Group) {
        self.group = group
    }
    
    /**
     Creates a NSCollectionLayoutSection for constructing compositional layout.
     
     - Returns: NSCollectionLayoutSection
     */
    internal func createLayoutSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group.createLayoutGroup())
        section.contentInsets = .init(top: contentInsets.top, leading: contentInsets.leading, bottom: contentInsets.bottom, trailing: contentInsets.trailing)
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = scrollingBehavior
        section.boundarySupplementaryItems = sectionBoundarySupplementaryItems
        section.decorationItems = decorationItems
        section.visibleItemsInvalidationHandler = visibleItemInvalidationHandler
        
        return section
    }
}

extension Section {
    /// Set the space between the content of the section and its boundaries.
    public func contentInsets(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        self.contentInsets = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
        
        return self
    }
    
    /// Set the amount of space between the groups in the section.
    public func interGroupSpacing(_ spacing: CGFloat) -> Self {
        self.interGroupSpacing = spacing
        
        return self
    }
    
    /**
     Set the scrolling behavior of the section.
     
     - Parameter behavior: The scrolling behavior of the layout’s sections in relation to the main layout axis.
     */
    public func scrollingBehavior(_ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> Self {
        self.scrollingBehavior = behavior
        
        return self
    }
    
    /**
     Set the animation for the items in the section. This function is called before the layout cycle whenever an animation occurs.
     
     - Parameter handler: Set animation using currently visible item, scroll offset, layout environment.
     */
    public func visibleItemInvalidationHandler(_ handler: @escaping NSCollectionLayoutSectionVisibleItemsInvalidationHandler) -> Self {
        self.visibleItemInvalidationHandler = handler
        
        return self
    }
    
    /// Set the decoration items that are anchored to the section, such as background decoration views.
    public func decorationItems(_ items: [DecorationItem]) -> Self {
        self.decorationItems = items.map { $0.createDecorationItem() }
        
        return self
    }
    
    /// Set the supplementary items that are associated with the boundary edges of the section, such as headers and footers.
    public func boundarySupplementaryItems(_ items: [SupplementaryView]) -> Self {
        self.sectionBoundarySupplementaryItems = items.map { $0.createBoundarySupplementaryItem() }
        
        return self
    }
}
