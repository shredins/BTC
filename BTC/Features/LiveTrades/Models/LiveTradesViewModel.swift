//
//  LiveTradesViewModel.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import FDTTableViewManager

class LiveTradesViewModel: LiveTradesViewModelProtocol {

    // MARK: - Properties
    let title: String = .title
    let uiQueue: DispatchQueue
    var cellItems: [LiveTradeCellItem] = []
    let tradesStorage: TradesStorageProtocol = inject()
    let config: LiveTradesConfigurationProtocol = inject()

    // MARK: - Weak Properties
    weak var delegate: LiveTradesViewModelDelegate?
    weak var uiDelegate: LiveTradesViewModelUIDelegate?

    // MARK: - Private Properties
    private let cleanUpTitleDuration: TimeInterval
    private var previousContentOffset: CGFloat = 0
    private var sourceRestorer: SourceRestorerProtocol?

    // MARK: - Observed Properties
    private var titleType: TitleType = .standard {
        didSet {
            let title: String = titleType == .standard ? .title : .cleanUpTitle
            delegate?.liveTradesViewModel(self, didChange: title)
        }
    }

    private var isScrolledTop: Bool = true {
        didSet {
            cellItems.forEach {
                $0.isScrolledTop = isScrolledTop
            }
        }
    }

    // MARK: - Lazy Properties
    lazy var analyzer: EventAnalyzerProtocol = {
        let analyzer: EventAnalyzerProtocol = inject()
        analyzer.delegate = self
        return analyzer
    }()

    lazy var tableViewManager: TableViewManager = {
        let manager: TableViewManager = inject()
        manager.scrollViewDelegate = self
        return manager
    }()

    lazy var sourceObserver: SourceObserverProtocol = {
        let sourceObserver: SourceObserverProtocol = inject()
        sourceObserver.operationDelegate = self
        sourceObserver.delegate = self
        return sourceObserver
    }()

    // MARK: - Inits
    init(cleanUpTitleDuration: TimeInterval = .cleanUpTitleDuration, uiQueue: DispatchQueue = .main) {
        self.cleanUpTitleDuration = cleanUpTitleDuration
        self.uiQueue = uiQueue
    }

    // MARK: - Public Instance Methods
    func viewWillAppear() {
        uiDelegate?.liveTradesViewModel(self, askToHideIndicator: false)
    }

    func set(websocketManager: LiveTradesWebsocketManagerProtocol) {
        let newSource = BitstampSource(liveTradesWebsocketManager: websocketManager)
        sourceObserver.add(source: newSource)
    }
    
    func set(tableView: UITableView) {
        tableViewManager.tableView = tableView
    }

    func add(cellItem: LiveTradeCellItem) {
        if cellItems.isEmpty {
            let section = Section(rows: [cellItem])
            tableViewManager.add(sections: [section])
        } else {
            let insert: TableViewManager.RowInsert = .insert(item: cellItem, indexPath: .zero)
            tableViewManager.add(animation: .fade, inserts: [insert])
        }
    }

    // MARK: - Private Properties
    private func moveTradesToStorage() {
        let toRemove = cellItems.prefix(config.numberOfStoredTrades)
        let array = Array(toRemove)
        let removeCount = min(cellItems.count, config.numberOfStoredTrades)

        cellItems.removeFirst(removeCount)
        tradesStorage.store(cellItems: array)
        tableViewManager.delete(items: array)

        titleType = .cleanUp

        uiQueue.asyncAfter(deadline: .now() + cleanUpTitleDuration) { [weak self] in
            self?.titleType = .standard
        }
    }

}

// MARK: - SourceRestorerDelegate Methods
extension LiveTradesViewModel: SourceRestorerDelegate {

    func bitstampRestorerDidFailRestoring(_ restorer: BitstampRestorer) {
        let alert = AlertBuilder.restoreSource {
            restorer.restore()
        }
        delegate?.liveTradesViewModel(self, didAskToPresent: alert)
    }

    func bitstampRestorer(_ restorer: BitstampRestorer, didRestore source: SourceProtocol) {
        sourceObserver.add(source: source)
        sourceRestorer = nil
    }

}

// MARK: - SourceObserverDelegate Methods
extension LiveTradesViewModel: SourceObserverDelegate {

    func sourceObserver(_ observer: SourceObserverProtocol, didDetectSourceFailure source: SourceProtocol) {
        guard var restorer = RestorerFactory.restorer(for: source) else {
            return
        }

        let alert = AlertBuilder.restoreSource { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.sourceRestorer = restorer
            restorer.delegate = strongSelf
            restorer.restore()
        }

        delegate?.liveTradesViewModel(self, didAskToPresent: alert)
    }

}

// MARK: - TableViewManagerScrollViewDelegate Methods
extension LiveTradesViewModel: TableViewManagerScrollViewDelegate {

    func tableViewManager(_ manager: TableViewManager, scrollViewDidScroll scrollView: UIScrollView) {
        isScrolledTop = scrollView.contentOffset.y < previousContentOffset
        previousContentOffset = scrollView.contentOffset.y
    }

}

// MARK: - LiveTradeOperationDelegate Methods
extension LiveTradesViewModel: LiveTradeOperationDelegate {

    func liveTradeOperationDelegate(_ operation: LiveTradeOperation, didProduce cellItem: LiveTradeCellItem) {
        cellItem.isScrolledTop = isScrolledTop

        uiQueue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.uiDelegate?.liveTradesViewModel(strongSelf, askToHideIndicator: true)
            strongSelf.add(cellItem: cellItem)
            strongSelf.cellItems.append(cellItem)
            strongSelf.analyzer.liveTradeAdded()
        }
    }

}

// MARK: - EventAnalyzerDelegate Methods
extension LiveTradesViewModel: EventAnalyzerDelegate {

    func eventAnalyzer(_ analyzer: EventAnalyzerProtocol, didCommand order: EventAnalyzerOrder) {
        switch order {
        case .loadFromREST:
            let newSource = RESTSource()
            sourceObserver.add(source: newSource)
        case .storeLastTrades:
            moveTradesToStorage()
        }
    }

}

private extension LiveTradesViewModel {

    enum TitleType {
        case standard
        case cleanUp
    }

}

private extension IndexPath {
    static let zero = IndexPath(row: 0, section: 0)
}

private extension TimeInterval {
    static let cleanUpTitleDuration = 2.5
}

private extension String {
    static let title = "live.trades.title"
    static let cleanUpTitle = "live.trades.clean.up.prompt"
}
