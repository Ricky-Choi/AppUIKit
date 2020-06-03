//
//  AUITabBarItem.swift
//  AppUIKit
//
//  Created by Jae Young Choi on 2017. 1. 18..
//  Copyright © 2017년 appcid. All rights reserved.
//

import Cocoa

public enum AUITabBarSystemItem : Int, CustomStringConvertible {
    case more
    case favorites
    case featured
    case topRated
    case recents
    case contacts
    case history
    case bookmarks
    case search
    case downloads
    case mostRecent
    case mostViewed
    
    var title: String {
        switch self {
        case .more: return "More"
        case .favorites: return "Favorites"
        case .featured: return "Featured"
        case .topRated: return "Top Rated"
        case .recents: return "Recents"
        case .contacts: return "Contacts"
        case .history: return "History"
        case .bookmarks: return "Bookmarks"
        case .search: return "Search"
        case .downloads: return "Downloads"
        case .mostRecent: return "Most Recent"
        case .mostViewed: return "Most Viewed"
        }
    }
    
    public var description: String {
        return title
    }
    
    var image: NSImage! {
        switch self {
        case .more: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarMore)
        case .favorites: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavorites)
        case .featured: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavorites)
        case .topRated: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavorites)
        case .recents: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistory)
        case .contacts: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarContacts)
        case .history: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistory)
        case .bookmarks: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarBookmarks)
        case .search: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarSearch)
        case .downloads: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarDownloads)
        case .mostRecent: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistory)
        case .mostViewed: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarMostViewed)
        }
    }
    
    var selectedImage: NSImage! {
        switch self {
        case .more: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarMoreSelected)
        case .favorites: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavoritesSelected)
        case .featured: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavoritesSelected)
        case .topRated: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarFavoritesSelected)
        case .recents: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistorySelected)
        case .contacts: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarContactsSelected)
        case .history: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistorySelected)
        case .bookmarks: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarBookmarksSelected)
        case .search: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarSearchSelected)
        case .downloads: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarDownloadsSelected)
        case .mostRecent: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarHistorySelected)
        case .mostViewed: return Bundle(for: AUITabBarItem.self).image(forResource: .tabBarMostViewedSelected)
        }
    }
    
}

extension NSImage.Name {

}

open class AUITabBarItem: AUIBarItem {
    public override init() {
        super.init()
    }
    
    /* The unselected image is autogenerated from the image argument. The selected image
     is autogenerated from the selectedImage if provided and the image argument otherwise.
     To prevent system coloring, provide images with UIImageRenderingModeAlwaysOriginal (see UIImage.h)
     */
    public convenience init(title: String?, image: NSImage?, tag: Int) {
        self.init()
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    public convenience init(title: String?, image: NSImage?, selectedImage: NSImage?) {
        self.init()
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
    
    public convenience init(tabBarSystemItem systemItem: AUITabBarSystemItem, tag: Int) {
        self.init()
        self.title = systemItem.title
        self.image = systemItem.image
        self.selectedImage = systemItem.selectedImage
        self.tag = tag
    }
    
    fileprivate var _selectedImage: NSImage? {
        didSet {
            invalidateBadge()
        }
    }
    open var selectedImage: NSImage? {
        set {
            _selectedImage = newValue
        }
        get {
            return _selectedImage ?? image
        }
    }
    open var badgeValue: String? {
        didSet {
            invalidateBadge()
        }
    }// default is nil
    
    
    /* To set item label text attributes use the appearance selectors available on the superclass, UIBarItem.
     
     Use the following to tweak the relative position of the label within the tab button (for handling visual centering corrections if needed because of custom text attributes)
     */
    open var titlePositionAdjustment: AUIOffset = .zero
    
    
    /// If this item displays a badge, this color will be used for the badge's background. If set to nil, the default background color will be used instead.
    @NSCopying open var badgeColor: NSColor? {
        didSet {
            invalidateBadge()
        }
    }
    
    fileprivate var _badgeTextAttributes = [AUIControlState: [String: Any]]() {
        didSet {
            invalidateBadge()
        }
    }
    /// Provide text attributes to use to draw the badge text for the given singular control state (Normal, Disabled, Focused, Selected, or Highlighted). Default values will be supplied for keys that are not provided by this dictionary. See NSAttributedString.h for details on what keys are available.
    open func setBadgeTextAttributes(_ textAttributes: [String : Any]?, for state: AUIControlState) {
        if state == .default {
            _badgeTextAttributes[.default] = textAttributes
        }
        
        for controlState in AUIControlState.notDefaultStates {
            if state.contains(controlState) {
                _badgeTextAttributes[controlState] = textAttributes
            }
        }
    }
    
    
    /// Returns attributes previously set via -setBadgeTextAttributes:forState:.
    open func badgeTextAttributes(for state: AUIControlState) -> [String : Any]? {
        return _badgeTextAttributes[state] ?? _badgeTextAttributes[.default]
    }
}

extension AUITabBarItem {
    func invalidateBadge() {
        
    }
}
