//
// Theme.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation

/// Themes allow you to have complete control over the HTML used to generate
/// your pages.
///
/// Example:
/// ```swift
/// struct BlogLayout: Theme {
///     var body: some HTML {
///         HTMLDocument {
///             Header("My Blog")
///             HTMLBody(for: page)
///             Footer()
///         }
///     }
/// }
/// ```
@MainActor
public protocol Theme: Sendable {
    /// The type of HTML content this layout will generate
    associatedtype Body: HTML

    /// The main content of the layout, built using the HTML DSL
    var body: Body { get }

    /// A unique identifier for this layout instance
    var id: String { get set }
}

public extension Theme {
    var page: Page {
        /// The current page being rendered.
        PageContext.current
    }

    /// Generates a unique identifier for this layout based on its file location and type.
    /// The identifier is used internally for tracking and caching purposes.
    var id: String {
        get {
            let location = #filePath + #line.description
            let description = String(describing: self)
            return (location + description).truncatedHash
        }
        set {}
    }
}
