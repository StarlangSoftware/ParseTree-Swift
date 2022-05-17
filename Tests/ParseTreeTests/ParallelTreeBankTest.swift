import XCTest
@testable import ParseTree
import ParseTree

final class ParallelTreeBankTest: XCTestCase {
    
    func testSize() {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let treeBank1 = ParallelTreeBank(folder1: thisDirectory.appendingPathComponent("trees").path, folder2: thisDirectory.appendingPathComponent("trees2").path)
        XCTAssertEqual(3, treeBank1.size())
    }
    
    static var allTests = [
        ("testExample1", testSize),
    ]
}
