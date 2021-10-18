import ObjectMapper

class MarketInfoRaw: ImmutableMappable {
    let uid: String
    let price: Decimal?
    let priceChange24h: Decimal?
    let priceChange7d: Decimal?
    let priceChange14d: Decimal?
    let priceChange200d: Decimal?
    let priceChange1y: Decimal?
    let marketCap: Decimal?
    let totalVolume: Decimal?
    let ath: Decimal?
    let atl: Decimal?

    required init(map: Map) throws {
        uid = try map.value("uid")
        price = try? map.value("price", using: Transform.stringToDecimalTransform)
        priceChange24h = try? map.value("price_change_24h", using: Transform.stringToDecimalTransform)
        priceChange7d = try? map.value("price_change_7d", using: Transform.stringToDecimalTransform)
        priceChange14d = try? map.value("price_change_14d", using: Transform.stringToDecimalTransform)
        priceChange200d = try? map.value("price_change_200d", using: Transform.stringToDecimalTransform)
        priceChange1y = try? map.value("price_change_1y", using: Transform.stringToDecimalTransform)
        marketCap = try? map.value("market_cap", using: Transform.stringToDecimalTransform)
        totalVolume = try? map.value("total_volume", using: Transform.stringToDecimalTransform)
        ath = try? map.value("ath", using: Transform.stringToDecimalTransform)
        atl = try? map.value("atl", using: Transform.stringToDecimalTransform)
    }

    func marketInfo(fullCoin: FullCoin) -> MarketInfo {
        MarketInfo(
                fullCoin: fullCoin,
                price: price,
                priceChange24h: priceChange24h,
                priceChange7d: priceChange7d,
                priceChange14d: priceChange14d,
                priceChange200d: priceChange200d,
                priceChange1y: priceChange1y,
                marketCap: marketCap,
                totalVolume: totalVolume,
                ath: ath,
                atl: atl
        )
    }

}
