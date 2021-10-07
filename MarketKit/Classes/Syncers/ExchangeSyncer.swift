import RxSwift

class ExchangeSyncer {
    private let exchangeManager: ExchangeManager
    private let coinGeckoProvider: CoinGeckoProvider
    private let disposeBag = DisposeBag()

    init(exchangeManager: ExchangeManager, coinGeckoProvider: CoinGeckoProvider) {
        self.exchangeManager = exchangeManager
        self.coinGeckoProvider = coinGeckoProvider
    }

    private func handleFetch(error: Error) {
        print("MarketCoins fetch error: \(error)")
    }

    private func fetch(limit: Int, page: Int) -> Single<[Exchange]> {
        coinGeckoProvider.exchangesSingle(limit: limit, page: page)
                .flatMap { [weak self] exchanges -> Single<[Exchange]> in
                    guard let syncer = self else {
                        return Single.just([])
                    }

                    guard exchanges.count >= limit else {
                        return Single.just(exchanges)
                    }

                    return syncer.fetch(limit: limit, page: page + 1).map { exchanges + $0 }
                }
    }

}

extension ExchangeSyncer {

    func sync() {
        fetch(limit: 0, page: 0)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
                .subscribe(onSuccess: { [weak self] exchanges in
                    self?.exchangeManager.handleFetched(exchanges: exchanges)
                }, onError: { [weak self] error in
                    self?.handleFetch(error: error)
                })
                .disposed(by: disposeBag)
    }

}
