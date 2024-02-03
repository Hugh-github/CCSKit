# CCSKit
CCSKit is make to easy create **UICollectionViewCompostionalLayout**.

[![CI Status](https://img.shields.io/travis/Hugh-github/CCSKit.svg?style=flat)](https://travis-ci.org/Hugh-github/CCSKit)
[![Version](https://img.shields.io/cocoapods/v/CCSKit.svg?style=flat)](https://cocoapods.org/pods/CCSKit)
[![License](https://img.shields.io/cocoapods/l/CCSKit.svg?style=flat)](https://cocoapods.org/pods/CCSKit)
[![Platform](https://img.shields.io/cocoapods/p/CCSKit.svg?style=flat)](https://cocoapods.org/pods/CCSKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
+ **iOS 13.0+**
+ **Swift 4.0+**

## Installation
### CocoaPods
CCSKit is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

``` ruby
pod 'CCSKit'
```

Install the pods by running pod install.

```ruby
$ pod install
```

## Usage
CCSKit is similar to `UICollectionViewCompositionalLayout`. Easily set properties using builder patterns. And it is easy to create frequently used grids, nested group sections.

### Basic
```swift
let item = Item(width: .fixed(120), height: .fixed(30))
let group = Group(width: .fixed(120), height: .fixed(150), subitems: [item], arrangedDirection: .vertical)
let section = Section(group: group)
```

### GridSection
```swift
let gridSection = GridSection(rowWidth: .fractionalWidth(1.0), rowHeight: .fractionalHeight(0.1), numberOfItemInRow: 3)
    .interItemSpaicng(10)
    .interGroupSpacing(10)
    .scrollingBehavior(.continuous)
```

### NestedGroupSection
```swift
let firstSection = NestedGroupsSection(groupWidth: .fractionalWidth(1.0), groupHeight: .fractionalHeight(0.3), arrangedDirection: .vertical, numberOfItemsInInnerGroups: [1, 2, 2])
    .innerGroupsFractionalSize([0.5, 0.25, 0.25])
    .interInnerGroupSpacing(10)
    .contentInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    .scrollingBehavior(.continuous)
```

### SupplementaryItem & DecorationItem
Adding a supplement item to section is also similar to `UICollectionViewCompositionalLayout`.

```swift
let sectionHeader = SupplementaryView(width: .fractionalWidth(1.0), height: .fractionalHeight(0.05), elementKind: "TextHeader")
    .topItem()

let sectionBackground = DecorationItem(elementKind: "SectionBackground")

let nestedGroupSection = NestedGroupsSection(groupWidth: .fractionalWidth(1.0), groupHeight: .fractionalHeight(0.3), arrangedDirection: .vertical, numberOfItemsInInnerGroups: [1, 2, 2])
    .decorationItems([sectionBackground])
    .boundarySupplementaryItems([sectionHeader])
```

You can create a CollectionViewLayout using the section created through the CCSKit.

```swift
let gridSection = GridSection(rowWidth: .fractionalWidth(1.0), rowHeight: .fractionalHeight(0.1), numberOfItemInRow: 3)
    .interItemSpaicng(10)
    .interGroupSpacing(10)
    .scrollingBehavior(.continuous)

let layout = UICollectionViewCompositionalLayout(section: gridSection)
```

## Author

Hugh-github, tnghk4822@gmail.com

## License

CCSKit is available under the MIT license. See the LICENSE file for more info.
