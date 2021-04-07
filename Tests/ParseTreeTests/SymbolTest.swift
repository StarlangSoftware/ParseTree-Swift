import XCTest
@testable import ParseTree

final class SymbolTest: XCTestCase {
    
    func testTrimSymbol() {
        XCTAssertEqual("NP", Symbol(name: "NP-SBJ").trimSymbol().getName())
        XCTAssertEqual("VP", Symbol(name: "VP-SBJ-2").trimSymbol().getName())
        XCTAssertEqual("NNP", Symbol(name: "NNP-SBJ-OBJ-TN").trimSymbol().getName())
        XCTAssertEqual("S", Symbol(name: "S-SBJ=OBJ").trimSymbol().getName())
    }

    static var allTests = [
        ("testExample", testTrimSymbol),
    ]
}
