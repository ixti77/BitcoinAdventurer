struct PriceResponse: Codable {
  let data: Price
  let warnings: [Error]?
}
