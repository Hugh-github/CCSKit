//
//  UICollectionViewCompositionalLayout+extension.swift
//  CCSKit
//
//  Created by dhoney96 on 2/2/24.
//

import UIKit

/// A closure that creates and returns each of the sections.
public typealias SectionProvider = (Int, NSCollectionLayoutEnvironment) -> Section?

extension UICollectionViewCompositionalLayout {
    public convenience init(section: Section) {
        self.init(section: section.createLayoutSection())
    }
    
    public convenience init(section: Section, configuration: UICollectionViewCompositionalLayoutConfiguration) {
        self.init(section: section.createLayoutSection(), configuration: configuration)
    }
    
    public convenience init(sections: [Section]) {
        self.init { index, _ in
            return sections[index].createLayoutSection()
        }
    }
    
    public convenience init(sections: [Section], configuration: UICollectionViewCompositionalLayoutConfiguration) {
        self.init(
            sectionProvider: { index, _ in
                return sections[index].createLayoutSection()
        },
            configuration: configuration
        )
    }
    
    public convenience init(sectionProvider: @escaping SectionProvider) {
        self.init(sectionProvider: { index, environment in
            return sectionProvider(index, environment)?.createLayoutSection()
        })
    }
    
    public convenience init(sectionProvider: @escaping SectionProvider, configuration: UICollectionViewCompositionalLayoutConfiguration) {
        self.init(sectionProvider: { index, environment in
            return sectionProvider(index, environment)?.createLayoutSection()
        },
            configuration: configuration
        )
    }
}
