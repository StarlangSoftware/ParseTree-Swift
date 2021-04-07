import XCTest
@testable import ParseTree

final class ParseTreeTest: XCTestCase {
    
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
    
    func testNodeCount() {
        XCTAssertEqual(34, parseTree1.nodeCount())
        XCTAssertEqual(39, parseTree2.nodeCount())
        XCTAssertEqual(32, parseTree3.nodeCount())
        XCTAssertEqual(28, parseTree4.nodeCount())
        XCTAssertEqual(9, parseTree5.nodeCount())
    }
    
    func testIsFullSentence() {
        XCTAssertTrue(parseTree1.isFullSentence())
        XCTAssertTrue(parseTree2.isFullSentence())
        XCTAssertTrue(parseTree3.isFullSentence())
        XCTAssertTrue(parseTree4.isFullSentence())
        XCTAssertFalse(parseTree5.isFullSentence())
    }

    func testLeafCount() {
        XCTAssertEqual(13, parseTree1.leafCount())
        XCTAssertEqual(15, parseTree2.leafCount())
        XCTAssertEqual(10, parseTree3.leafCount())
        XCTAssertEqual(10, parseTree4.leafCount())
        XCTAssertEqual(4, parseTree5.leafCount())
    }

    func testNodeCountWithMultipleChildren() {
        XCTAssertEqual(8, parseTree1.nodeCountWithMultipleChildren())
        XCTAssertEqual(9, parseTree2.nodeCountWithMultipleChildren())
        XCTAssertEqual(8, parseTree3.nodeCountWithMultipleChildren())
        XCTAssertEqual(6, parseTree4.nodeCountWithMultipleChildren())
        XCTAssertEqual(1, parseTree5.nodeCountWithMultipleChildren())
    }

    func testToSentence() {
        XCTAssertEqual("The complicated language in the huge new law has muddied the fight .", parseTree1.toSentence())
        XCTAssertEqual("The Ways and Means Committee will hold a hearing on the bill next Tuesday .", parseTree2.toSentence())
        XCTAssertEqual("We 're about to see if advertising works .", parseTree3.toSentence())
        XCTAssertEqual("This time around , they 're moving even faster .", parseTree4.toSentence())
        XCTAssertEqual("Ad Notes ... .", parseTree5.toSentence())
    }
    
    func testConstituentSpan(){
        var span : ConstituentSpan = parseTree1.constituentSpanList()[6]
        XCTAssertEqual(Symbol(name: "PP-LOC"), span.getConstituent())
        XCTAssertEqual(4, span.getStart())
        XCTAssertEqual(9, span.getEnd())
        span = parseTree2.constituentSpanList()[10]
        XCTAssertEqual(Symbol(name: "VB"), span.getConstituent())
        XCTAssertEqual(7, span.getStart())
        XCTAssertEqual(8, span.getEnd())
        span = parseTree3.constituentSpanList()[0]
        XCTAssertEqual(Symbol(name: "S"), span.getConstituent())
        XCTAssertEqual(1, span.getStart())
        XCTAssertEqual(11, span.getEnd())
        span = parseTree4.constituentSpanList()[5]
        XCTAssertEqual(Symbol(name: "ADVP"), span.getConstituent())
        XCTAssertEqual(3, span.getStart())
        XCTAssertEqual(4, span.getEnd())
        span = parseTree5.constituentSpanList()[4]
        XCTAssertEqual(Symbol(name: "."), span.getConstituent())
        XCTAssertEqual(4, span.getStart())
        XCTAssertEqual(5, span.getEnd())
    }

    static var allTests = [
        ("testExample1", testNodeCount),
        ("testExample2", testIsFullSentence),
        ("testExample3", testLeafCount),
        ("testExample4", testNodeCountWithMultipleChildren),
        ("testExample5", testToSentence),
    ]
}
