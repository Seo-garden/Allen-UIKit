import UIKit

let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f32d5ae15b72378543d7b0c287ab406a&targetDt=20211129"

let structURL = URL(string: movieURL)!

let session = URLSession.shared

let task = session.dataTask(with: structURL) { data, response, error in
    if error != nil {
        print(error!)
        return
    }
    guard let safeData = data else{
        //데이터를 우리가 사용하려는 형태(구조체/클래스)로 변형해서 사용
        //데이터를 한번 출력해보는 코드
        //print(String(decoding: safeData, as: UTF8.self))
        return
    }
    dump(parseJSON(safeData)!)      // 실행결과가 JSON 형식처럼 깔끔하게 출력된다.
}

task.resume()

//서버에서 주는 데이터 형태

func parseJSON(_ movieData: Data) -> [DailyBoxOfficeList]? {
    do {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(MovieData.self, from: movieData)
        return decodedData.boxOfficeResult.dailyBoxOfficeList
    } catch {
        print("에러가 발생했습니다 : \(error)")
        return nil
    }
}

struct MovieData: Codable {
    let boxOfficeResult : BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank : String
    let movieNm: String
    let audiCnt,audiAcc: String
    let openDt : String
}
