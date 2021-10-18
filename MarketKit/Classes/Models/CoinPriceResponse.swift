import Foundation
import ObjectMapper

struct CoinPriceResponse: ImmutableMappable {
    let uid: String
    let price: Decimal
    let priceChange: Decimal
    let lastUpdated: TimeInterval

    init(map: Map) throws {
        uid = try map.value("uid")
        price = try map.value("price", using: Transform.stringToDecimalTransform)
        priceChange = try map.value("price_change_24h", using: Transform.stringToDecimalTransform)
        lastUpdated = try map.value("last_updated")
    }

    func coinPrice(currencyCode: String) -> CoinPrice {
        CoinPrice(
            coinUid: uid,
            currencyCode: currencyCode,
            value: price,
            diff: priceChange,
            timestamp: lastUpdated
        )
    }

}
