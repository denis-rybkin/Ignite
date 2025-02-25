//
// AnyHTML.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// A type-erasing wrapper that can hold any HTML content while maintaining protocol conformance.
/// This wrapper also handles unwrapping nested AnyHTML instances to prevent unnecessary wrapping layers.
public struct AnyHTML: HTML, BlockElement, InlineElement {
    /// The body of this HTML element, which is itself
    public var body: some HTML { self }
    
    /// The column width for this element when used in a grid layout
    public var columnWidth: ColumnWidth = .automatic
    
    /// The underlying HTML content, unwrapped to its most basic form
    let wrapped: any HTML
    
    /// Creates a new AnyHTML instance that wraps the given HTML content.
    /// If the content is already an AnyHTML instance, it will be unwrapped to prevent nesting.
    /// - Parameter content: The HTML content to wrap
    public init(_ content: any HTML) {
        // Recursively unwrap nested AnyHTML instances
        if let anyHTML = content as? AnyHTML {
            self.wrapped = anyHTML.unwrappedContent
        } else {
            self.wrapped = content
        }
        
        if let content = wrapped as? (any BlockElement) {
            self.columnWidth = content.columnWidth
        }
    }
    
    /// Helper property that recursively unwraps nested AnyHTML instances
    /// to get to the underlying content
    private var unwrappedContent: any HTML {
        if let anyHTML = wrapped as? AnyHTML {
            return anyHTML.unwrappedContent
        }
        return wrapped
    }
    
    /// Renders the wrapped HTML content using the given publishing context
    /// - Parameter context: The context to use for rendering
    /// - Returns: The rendered HTML string
    public func render(context: PublishingContext) -> String {
        wrapped.render(context: context)
    }
}
