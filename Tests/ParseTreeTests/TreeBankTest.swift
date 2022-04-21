import XCTest
@testable import ParseTree

final class TreeBankTest: XCTestCase {
    
    var treeBank1 : TreeBank = TreeBank()

    override func setUp() {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        treeBank1 = TreeBank(folder: thisDirectory.appendingPathComponent("trees").path)
    }
    
    func testSize() {
        XCTAssertEqual(5, treeBank1.size())
    }

    func testWordCount() {
        XCTAssertEqual(30, treeBank1.wordCount(excludeStopWords: true))
        XCTAssertEqual(52, treeBank1.wordCount(excludeStopWords: false))
    }

    static var allTests = [
        ("testExample1", testSize),
        ("testExample2", testWordCount),
    ]
}
