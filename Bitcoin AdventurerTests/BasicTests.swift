
import XCTest
import Swinject

@testable import Bitcoin_Adventurer

class BasicTests: XCTestCase {
  
  private let container = Container()
  
  // MARK: - Boilerplate methods
  
  override func setUp() {
    super.setUp()
		
		container.register(Currency.self) { _ in .USD }
		container.register(CryptoCurrency.self) { _ in .BTC }
		
		container.register(Price.self) { resolver in
			let crypto = resolver.resolve(CryptoCurrency.self)!
			let currency = resolver.resolve(Currency.self)!
			
			return Price(
				base: crypto,
				amount: "999456",
				currency: currency
			)
		}
		
		container.register(PriceResponse.self) { resolver in
			let price = resolver.resolve(Price.self)!
			return PriceResponse(data: price, warnings: nil)
		}
  }
  
  override func tearDown() {
    super.tearDown()
    container.removeAll()
  }
  
  // MARK: - Tests
  
  func testPriceResponseData() {
		let response = container.resolve(PriceResponse.self)!
		XCTAssertEqual(response.data.amount, "999456")
  }
}
