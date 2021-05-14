import XCTest
@testable import ParseTree

final class NodeColectorTest: XCTestCase {
    
    var parseTree1 : ParseTree = ParseTree()
    var parseTree2 : ParseTree = ParseTree()
    var parseTree3 : ParseTree = ParseTree()
    var parseTree4 : ParseTree = ParseTree()
    var parseTree5 : ParseTree = ParseTree()

    override func setUp() {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        parseTree1 = ParseTree(url: thisDirectory.appendingPathComponent("trees/0000.dev"))
        parseTree2 = ParseTree(url: thisDirectory.appendingPathComponent("trees/0001.dev"))
        parseTree3 = ParseTree(url: thisDirectory.appendingPathComponent("trees/0002.dev"))
        parseTree4 = ParseTree(url: thisDirectory.appendingPathComponent("trees/0003.dev"))
        parseTree5 = ParseTree(url: thisDirectory.appendingPathComponent("trees/0014.dev"))
    }
    
    func testCollectLeaf() {
        var nodeCollector1 : NodeCollector = NodeCollector(rootNode: parseTree1.getRoot()!, condition: IsLeaf())
        XCTAssertEqual(13, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree2.getRoot()!, condition: IsLeaf())
        XCTAssertEqual(15, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree3.getRoot()!, condition: IsLeaf())
        XCTAssertEqual(10, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree4.getRoot()!, condition: IsLeaf())
        XCTAssertEqual(10, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree5.getRoot()!, condition: IsLeaf())
        XCTAssertEqual(4, nodeCollector1.collect().count)
    }

    func testCollectNode() {
        var nodeCollector1 : NodeCollector = NodeCollector(rootNode: parseTree1.getRoot()!, condition: nil)
        XCTAssertEqual(34, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree2.getRoot()!, condition: nil)
        XCTAssertEqual(39, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree3.getRoot()!, condition: nil)
        XCTAssertEqual(32, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree4.getRoot()!, condition: nil)
        XCTAssertEqual(28, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree5.getRoot()!, condition: nil)
        XCTAssertEqual(9, nodeCollector1.collect().count)
    }

    func testCollectEnglish() {
        var nodeCollector1 : NodeCollector = NodeCollector(rootNode: parseTree1.getRoot()!, condition: IsEnglishLeaf())
        XCTAssertEqual(13, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree2.getRoot()!, condition: IsEnglishLeaf())
        XCTAssertEqual(15, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree3.getRoot()!, condition: IsEnglishLeaf())
        XCTAssertEqual(9, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree4.getRoot()!, condition: IsEnglishLeaf())
        XCTAssertEqual(10, nodeCollector1.collect().count)
        nodeCollector1 = NodeCollector(rootNode: parseTree5.getRoot()!, condition: IsEnglishLeaf())
        XCTAssertEqual(4, nodeCollector1.collect().count)
    }

    static var allTests = [
        ("testExample1", testCollectLeaf),
        ("testExample2", testCollectEnglish),
    ]
}
