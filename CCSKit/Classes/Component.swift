//
//  Section.swift
//  CCSKit
//
//  Created by dhoney96 on 1/10/24.
//

import UIKit

/**
 Representing an item's size(width, height) in collection view.
 */
public enum ComponentSize {
    case zero
    
    /// Create size with a fixed value.
    case fixed(CGFloat)
    
    /// Create size with an estimated value.
    case estimated(CGFloat)
    
    /// Create size with that is computed as a fraction of the width of the containing group.
    case fractionalWidth(CGFloat)
    
    /// Create size with that is computed as a fraction of the height of the containing group.
    case fractionalHeight(CGFloat)
    
    /// Dimenssion implementing CompositionalLayout(수정 필요)
    public var dimenssion: NSCollectionLayoutDimension {
        switch self {
        case .zero:
            return .absolute(0)
        case .fixed(let value):
            return .absolute(value)
        case .estimated(let value):
            return .estimated(value)
        case .fractionalWidth(let value):
            return .fractionalWidth(value)
        case .fractionalHeight(let value):
            return .fractionalHeight(value)
        }
    }
}

internal extension ComponentSize {
    /// Resize using number of items.
    func resize(to numberOfItem: Int) -> Self {
        switch self {
        case .zero:
            return .fixed(0)
        case .fixed(let value):
            return .fixed(value / CGFloat(numberOfItem))
        case .estimated(let value):
            return .estimated(value / CGFloat(numberOfItem))
        case .fractionalWidth(_):
            return .fractionalWidth(1 / CGFloat(numberOfItem))
        case .fractionalHeight(_):
            return .fractionalHeight(1 / CGFloat(numberOfItem))
        }
    }
    
    /// Resize using group size ratio in nested group.
    func resize(to ratio: CGFloat) -> Self {
        switch self {
        case .zero:
            return .fixed(0)
        case .fixed(let value):
            return .fixed(value * ratio)
        case .estimated(let value):
            return .estimated(value * ratio)
        case .fractionalWidth(_):
            return .fractionalWidth(ratio)
        case .fractionalHeight(_):
            return .fractionalHeight(ratio)
        }
    }
}

public enum ArrangedDirection {
    case vertical
    case horizontal
}

public enum Offset {
    case zero
    case absoulte(CGPoint)
    case fractional(CGPoint)
}
