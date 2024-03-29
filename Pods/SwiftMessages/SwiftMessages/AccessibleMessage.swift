//
//  AccessibleMessage.swift
//  SwiftMessages
//
//  Created by Timothy Moose on 3/11/17.
//  Copyright © 2017 SwiftKick Mobile. All rights reserved.
//

import Foundation

/**
 Message views that conform to `AccessibleMessage` will have proper accessibility behavior when displaying messages.
 `MessageView` implements this protocol.
 */
public protocol AccessibleMessage {
    var accessibilityMessage: String? { get }
    var accessibilityElement: NSObject? { get }
    var additionalAccessibilityElements: [NSObject]? { get }
}
