//
// IgniteFooter.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation

/// Displays "Created by Ignite", with a link back to the Ignite project on GitHub.
/// Including this is definitely not required for your site, but it's most appreciated 🙌
public struct IgniteFooter: HTML {
    public init() { }

    public var body: some HTML {
        Text {
            "Created with "
            Link("Ignite", target: URL("https://github.com/twostraws/Ignite"))
        }
        .horizontalAlignment(.center)
        .margin(.top, .extraLarge)
    }
}
