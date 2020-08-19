import FBSnapshotTestCase
import Foundation
import UIKit
import XCTest

//public class CallChecker {
//
//    public init(expected: Int = 1)
//
//    public func called()
//}

/// Interface to provide language support to UI Tests
public protocol Localizable {

    var locale: Locale { get }
}

/// Represents a screen with a navigation bar.
public protocol NavigationBarModel {

    var navigationTitle: String { get }

    var navigationBar: XCUIElement { get }
}

extension NavigationBarModel where Self : TestSupport.ScreenModel {

    public func waitForNavigationBarViewToAppear() -> Self

    public func waitForNavigationBarViewToNotAppear<T>(fromModel: @autoclosure () -> T) -> T where T : TestSupport.ScreenModel

    public func waitForBackButtonToNotAppear() -> Self

    public func tapOnBackButton<T>(toModel: @autoclosure () -> T) -> T where T : TestSupport.ScreenModel

    public var navigationBar: XCUIElement { get }
}

/// Defines a base class for screen models that will be automatically identified by the navigationBar.
open class NavigationModel : TestSupport.ScreenModel, TestSupport.NavigationBarModel {

    /// The designated element that represents the screen model and that will be used to assess the existance or not of the screen itself.
    override open var identifyingElement: XCUIElement { get }

    open var navigationTitle: String { get }
}

public struct SafariApp {

    /// Launches an instance of the Safari application and opens the given URL
    ///
    ///   - urlString: The URL of the resource to open
    ///   - shouldOpenDeepLink: True if the WebView has to open the associated app to the link
    ///   - timeout: The waiting timeout for the Safari app to be launched
    public static func launchAndOpen(link urlString: String, shouldOpenDeepLink: Bool = false, timeout: Double = 5)
}

/// Base class that represents the interactions with the presented screens.
/// Actions (such as tapOnContinue()) and expectations (such as waitForNavigationBarToAppear())
/// are defined in subclasses.
/// Each method will return an instance of model to mimick the navigation between screens.
open class ScreenModel {

    /// The test case currently in execution
    public let test: TestSupport.UITestableCase

    /// The active instance of the application being tested
    public var app: XCUIApplication { get }

    public init(_ test: TestSupport.UITestableCase, file: StaticString = #file, function: StaticString = #function, line: Int = #line)

    /// The designated element that represents the screen model and that will be used to assess the existance or not of the screen itself.
    open var identifyingElement: XCUIElement { get }

    /// Returns an instance of ScreenModel and reports the step to TestReporter
    ///
    /// - Parameter function: The calling function (default: #function)
    /// - Returns: the current ScreenModel
    public func reportSelf(_ function: StaticString = #function) -> Self

    /// Use this to indefinitely pause the execution of the test
    ///
    /// You can use this during development, as a way of using a partial UI test to prefill content and help you reach the place you want
    @available(*, deprecated, message: "This is for development purposes only. Please remove before committing.")
    public func waitIndefinitely()
}

extension ScreenModel : TestSupport.SnapshotModel {

    public var snapshotTestCase: FBSnapshotTestCase { get }
}

public struct ScreenModelConstants {

    public static let defaulToleranceForBlinkingCursor: CGFloat
}

public protocol SnapshotModel {

    var snapshotTestCase: FBSnapshotTestCase { get }
}

extension SnapshotModel where Self : TestSupport.ScreenModel {

    public func verifyView(snapshotName: String? = nil, tolerence: CGFloat = 0, file: StaticString = #file, line: UInt = #line) -> Self

    public func verifyViewSkippingKeyboard(snapshotName: String? = nil, tolerence: CGFloat = ScreenModelConstants.defaulToleranceForBlinkingCursor, file: StaticString = #file, line: UInt = #line) -> Self
}

/// Represents a screen with a tab bar.
public protocol TabBarModel {
}

extension TabBarModel where Self : TestSupport.ScreenModel {

    public func tap<T>(on tab: String, toModel: @autoclosure () -> T) -> T where T : TestSupport.ScreenModel
}

public protocol TableViewModel {
}

extension TableViewModel where Self : TestSupport.ScreenModel {

    public func tapOnFirstItem<T>(toModel: @autoclosure () -> T) -> T where T : TestSupport.ScreenModel

    public func tapOnTableCell<T>(cellIndex: Int, toModel: @autoclosure () -> T) -> T where T : TestSupport.ScreenModel

    public func pullDownToRefresh() -> Self
}

/// Exports the output of a test step
public class TestReporter {

    /// Defines the level of reporting.
    public struct Level : OptionSet {

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public let rawValue: Int

        /// Creates a new option set from the given raw value.
        ///
        /// This initializer always succeeds, even if the value passed as `rawValue`
        /// exceeds the static properties declared as part of the option set. This
        /// example creates an instance of `ShippingOptions` with a raw value beyond
        /// the highest element, with a bit mask that effectively contains all the
        /// declared static members.
        ///
        ///     let extraOptions = ShippingOptions(rawValue: 255)
        ///     print(extraOptions.isStrictSuperset(of: .all))
        ///     // Prints "true"
        ///
        /// - Parameter rawValue: The raw value of the option set to create. Each bit
        ///   of `rawValue` potentially represents an element of the option set,
        ///   though raw values may include bits that are not defined as distinct
        ///   values of the `OptionSet` type.
        public init(rawValue: Int)

        /// Prints the description of parameters in the console.
        public static let console: TestSupport.TestReporter.Level

        /// Writes the output of report to the disk
        public static let file: TestSupport.TestReporter.Level

        /// No logging
        public static let silent: TestSupport.TestReporter.Level

        /// Prints to both console and file.
        public static let verbose: TestSupport.TestReporter.Level
    }

    /// Current global reporter's level.
    public static var level: TestSupport.TestReporter.Level

    /// Logs the parameters according to the global `level`
    ///
    /// - Parameters:
    ///   - testFile: The calling testFile, used to define the scope of logging
    ///   - function: The message being logged
    public static func report(testFile: String, message: String)
}

public protocol UITestable {

    var app: XCUIApplication { get }
}

extension UITestable {

    /// Returns the launch arguments to use in UI Tests to configure the simulator context in which the tests are run
    /// - Parameters:
    ///   - localizable: the simulator locale to use
    ///   - userInterfaceStyle: the simulator interface style to adopt
    public func makeLaunchArguments(localizable: TestSupport.Localizable, userInterfaceStyle: UIUserInterfaceStyle) -> [String]
}

/// Defines a test case with UITestable attributes
public typealias UITestableCase = XCTestCase & TestSupport.UITestable

extension XCTestCase {

    /// Checks if the text of the element's label matches the expected string.
    ///
    /// - Parameters:
    ///   - element: The element to evaluate (must have a valid `label` attribute)
    ///   - string: The string to assert
    public func verifyLabel(_ element: XCUIElement, string: String, file: StaticString = #file, line: UInt = #line)

    /// Checks if the text inside a generic element matches the expected string.
    ///
    /// - Parameters:
    ///   - element: The element to evaluate (must have a valid `value` String attribute, such as a UITextField)
    ///   - string: The string to assert
    public func verifyValue(_ element: XCUIElement, string: String, file: StaticString = #file, line: UInt = #line)

    /// Wait for an element to exist (does not need to be visible or on screen)
    ///
    /// - Parameters:
    ///   - element: The element expected to exists
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToExist(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to exist and be hittable (visible and on screen)
    ///
    /// - Parameters:
    ///   - element: The element expected to be hittable
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToExistAndVisibleAndOnScreen(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to exist and be not-hittable (visible and on screen but disabled)
    ///
    /// - Parameters:
    ///   - element: The element expected to be visible but not-hittable
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToExistButNotHittable(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to not exist (does not need to be visible or on screen)
    ///
    /// - Parameters:
    ///   - element: The element expected to be not visible
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToNotExist(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to be enabled
    ///
    /// - Parameters:
    ///   - element: The element expected to be enabled
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToBeEnabled(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to NOT be enabled
    ///
    /// - Parameters:
    ///   - element: The element expected to be not be enabled
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToNotBeEnabled(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to be selected
    ///
    /// - Parameters:
    ///   - element: The element expected to be selected
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToBeSelected(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to NOT be selected
    ///
    /// - Parameters:
    ///   - element: The element expected to be not be selected
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToNotBeSelected(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to have keyboard focus
    ///
    /// - Parameters:
    ///   - element: The element expected to have keyboard focus
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToHaveKeyboardFocus(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)

    /// Wait for an element to NOT have keyboard focus
    ///
    /// - Parameters:
    ///   - element: The element expected to NOT have keyboard focus
    ///   - waitSeconds: The waiting timeout
    public func waitForElementToNotHaveKeyboardFocus(_ element: XCUIElement, waitSeconds: TimeInterval = 30.0, file: StaticString = #file, line: Int = #line)
}

extension XCTestCase {

    public func report(function: String)
}

extension XCUIElement {

    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    public func clearAndEnterText(text: String)

    /**
     Typing `return` is equivalent of pressing "done" button on keyboard
     but it's more reliable during UI tests
     */
    public func dismissKeyboard()
}

extension XCUIElement {

    /// Taps on a specific element's subview buttons (e.g. a UISegmentControl)
    ///
    /// - Parameter index: The index of the button to tap (in absolute left to right coordination)
    public func tap(at index: UInt)
}

extension XCUIElement {

    public func scroll(to element: XCUIElement, timeout: TimeInterval = 30.0)
}

