//
//  DecorationItem.swift
//  CCSKit
//
//  Created by dhoney96 on 2/1/24.
//

import UIKit

/// An object used to add a background to a section of a collection view.
public class DecorationItem: Item {
    final let elementKind: String
    
    public init(elementKind: String) {
        self.elementKind = elementKind
        super.init(width: .zero, height: .zero)
    }
    
    internal func createDecorationItem() -> NSCollectionLayoutDecorationItem {
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: elementKind)
        decorationItem.contentInsets = super.contentInsets
        
        return decorationItem
    }
}
