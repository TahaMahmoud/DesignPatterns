typealias XML = String
typealias JSON = String
typealias AnalyzedData = String

class StockDataProvider {
    func downloadStockData() -> XML {
        return "XML data"
    }
}
protocol Chart {
    func displayCharts(data: XML)
}
class ChartCoreClass: Chart {
    func displayCharts(data: XML) {
        print("display charts with \(data)")
    }
}
class AnalyticsLibrary {
    func displayAnalyzedCharts(data: JSON){
        print("display charts with \(data) analyzed")
    }
}
class XMLtoJSONAdapater: Chart {
    let analytics: AnalyticsLibrary
    init(analytics: AnalyticsLibrary) {
        self.analytics = analytics
    }
    func displayCharts(data: XML) {
        // Data conversion
        let XMLtoJSONData = "converted \(data) to JSON data"
        analytics.displayAnalyzedCharts(data: XMLtoJSONData)
    }
}
// Client (Application)
let provider = StockDataProvider()
let XMLData = provider.downloadStockData()
print("--- Client without adapter ---")
let client = ChartCoreClass()
client.displayCharts(data: XMLData)

print("--- Client with adapter ---")
let analyticsLib = AnalyticsLibrary()
let adaptedClient = XMLtoJSONAdapater(analytics: analyticsLib)
adaptedClient.displayCharts(data: XMLData)
