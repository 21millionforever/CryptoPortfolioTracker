//
//  MarketData.swift
//  CryptoPortfolioTracker
//
//  Created by Zhendong Chen on 1/27/24.
//

import Foundation

//{
//  "data": {
//    "active_cryptocurrencies": 12470,
//    "upcoming_icos": 0,
//    "ongoing_icos": 49,
//    "ended_icos": 3376,
//    "markets": 983,
//    "total_market_cap": {
//      "btc": 40487661.38362242,
//      "eth": 747226486.680554,
//      "ltc": 24912827985.290543,
//      "bch": 6961711931.786993,
//      "bnb": 5554480194.668267,
//      "eos": 2404956880402.437,
//      "xrp": 3203465233007.296,
//      "xlm": 14576149011071.238,
//      "link": 118272378284.45914,
//      "dot": 254182377650.3229,
//      "yfi": 233919418.33907765,
//      "usd": 1699393580533.5283,
//      "aed": 6241787651620.629,
//      "ars": 1397596762106291.8,
//      "aud": 2584629788749.989,
//      "bdt": 186683800788949.16,
//      "bhd": 640526931406.7959,
//      "bmd": 1699393580533.5283,
//      "brl": 8352689387680.335,
//      "cad": 2287638668435.2085,
//      "chf": 1467530019799.1152,
//      "clp": 1567605608363154.8,
//      "cny": 12060426301688.393,
//      "czk": 38755350361499.31,
//      "dkk": 11670925293030.111,
//      "eur": 1564303686636.1753,
//      "gbp": 1337157642481.3223,
//      "gel": 4554374795829.85,
//      "hkd": 13285604103574.06,
//      "huf": 606428599213389.6,
//      "idr": 26808358581311548,
//      "ils": 6264763452829.452,
//      "inr": 141249685808711.47,
//      "jpy": 251824637731360.88,
//      "krw": 2272743483701833,
//      "kwd": 522767453243.7243,
//      "lkr": 540421142919434.1,
//      "mmk": 3569212892360732,
//      "mxn": 29162273599387.57,
//      "myr": 8033883151972.235,
//      "ngn": 1531634957396638,
//      "nok": 17739799647831.44,
//      "nzd": 2793218455005.416,
//      "php": 95711549248016.17,
//      "pkr": 475502588356753.25,
//      "pln": 6837425101597.618,
//      "rub": 152548795682075.97,
//      "sar": 6372678343980.485,
//      "sek": 17750718251586.39,
//      "sgd": 2282625457372.635,
//      "thb": 60527352139670.14,
//      "try": 51557901839806.87,
//      "twd": 53140037263283.41,
//      "uah": 64227171578986.55,
//      "vef": 170160279218.82214,
//      "vnd": 41813579049027570,
//      "zar": 31928818372752.938,
//      "xdr": 1276830869765.9639,
//      "xag": 74525002153.48782,
//      "xau": 841879579.7963085,
//      "bits": 40487661383622.42,
//      "sats": 4048766138362242.5
//    },
//    "total_volume": {
//      "btc": 923615.1360964698,
//      "eth": 17045926.329287022,
//      "ltc": 568317957.2206593,
//      "bch": 158812396.01413047,
//      "bnb": 126710257.04188696,
//      "eos": 54862506267.09582,
//      "xrp": 73078287953.70207,
//      "xlm": 332514929056.1093,
//      "link": 2698060471.57472,
//      "dot": 5798474974.941187,
//      "yfi": 5336231.039816214,
//      "usd": 38767011467.86541,
//      "aed": 142389294770.8964,
//      "ars": 31882343398646.97,
//      "aud": 58961251712.62556,
//      "bdt": 4258679760210.561,
//      "bhd": 14611868127.410515,
//      "bmd": 38767011467.86541,
//      "brl": 190543738065.70505,
//      "cad": 52186212487.467,
//      "chf": 33477679190.201344,
//      "clp": 35760629728532.484,
//      "cny": 275125603686.29395,
//      "czk": 884097203329.2574,
//      "dkk": 266240204657.85925,
//      "eur": 35685305425.25036,
//      "gbp": 30503590371.42106,
//      "gel": 103895590733.87915,
//      "hkd": 303074680604.05194,
//      "huf": 13834008042307.771,
//      "idr": 611559297658443.9,
//      "ils": 142913424765.94214,
//      "inr": 3222224829082.593,
//      "jpy": 5744689594365.635,
//      "krw": 51846419631951.18,
//      "kwd": 11925508067.744764,
//      "lkr": 12328228660518.521,
//      "mmk": 81421819356267.5,
//      "mxn": 665257423593.1578,
//      "myr": 183271046714.33325,
//      "ngn": 34940057817175.88,
//      "nok": 404684956011.9,
//      "nzd": 63719631001.22577,
//      "php": 2183396930415.6743,
//      "pkr": 10847289590230.535,
//      "pln": 155977132290.38293,
//      "rub": 3479983083000.3643,
//      "sar": 145375207528.1744,
//      "sek": 404934034060.58154,
//      "sgd": 52071849803.63681,
//      "thb": 1380765810461.3074,
//      "try": 1176152360923.572,
//      "twd": 1212244448600.151,
//      "uah": 1465167060575.4688,
//      "vef": 3881740858.277362,
//      "vnd": 953862317166830.8,
//      "zar": 728368567582.384,
//      "xdr": 29127400231.323338,
//      "xag": 1700083868.8703966,
//      "xau": 19205177.48118049,
//      "bits": 923615136096.4698,
//      "sats": 92361513609646.98
//    },
//    "market_cap_percentage": {
//      "btc": 48.43586744660095,
//      "eth": 16.09743268106817,
//      "usdt": 5.655042279311555,
//      "bnb": 2.769502753829516,
//      "sol": 2.3791942118701814,
//      "xrp": 1.6977815687398181,
//      "usdc": 1.5380736766075729,
//      "steth": 1.2555316423258012,
//      "ada": 1.0086449672455897,
//      "avax": 0.7086456864433435
//    },
//    "market_cap_change_percentage_24h_usd": 0.591637417950896,
//    "updated_at": 1706386192
//  }
//}

struct GlobalData: Codable {
    let data: MarketData?
}


struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    
    
    
}