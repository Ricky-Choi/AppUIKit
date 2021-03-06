//
//  AUILabel.swift
//  AppUIKit
//
//  Created by ricky on 2016. 12. 5..
//  Copyright © 2016년 appcid. All rights reserved.
//

import Cocoa

open class AUILabel: NSTextField {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        isEditable = false
        isSelectable = false
        isBezeled = false
        isBordered = false
        backgroundColor = NSColor.clear
    }
    
    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
