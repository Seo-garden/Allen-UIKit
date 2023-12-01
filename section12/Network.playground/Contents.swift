import UIKit

let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f32d5ae15b72378543d7b0c287ab406a&targetDt=20231129"

let structURL = URL(string: movieURL)!

URLSession.shared.dataTask(with: structURL) { data, response, error in
    if error != nil {
        print(error!)
        return
    }
    if let safeData = data {
        print(String(decoding: safeData, as: UTF8.self))
    }
}.resume()

