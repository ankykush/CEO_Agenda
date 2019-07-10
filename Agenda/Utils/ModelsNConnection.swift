import Foundation

typealias ScheduleData = [ScheduleElement]
typealias ScheduleArray = [Schedule]

struct ScheduleElement: Codable {
    let dates: String
    let month: String
    let date, day: String
    let logo: String
    let place, meetingdatecount: String
    let schedule: ScheduleArray
    
    init() {
        self.dates = ""
        self.month = ""
        self.date = ""
        self.day = ""
        self.logo = ""
        self.place = ""
        self.meetingdatecount = ""
        self.schedule = []
    }
}


struct Schedule: Codable {
    let meeting, place, time, longTime: String
    let desc: String
    let name: [String]
    let availableProfile: [String]
    let priority: Int
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case food = "Food"
    case meeting = "Meeting"
    case other = "Other"
    case reception = "Reception"
    case travel = "Travel"
}

struct Executive: Codable {
    let orgNames: [String]?
    let executives: [ExecutiveElement]?
    
    enum CodingKeys: String, CodingKey {
        case orgNames
        case executives
    }
}

// MARK: - ExecutiveElement
struct ExecutiveElement: Codable {
    let name, nickName, designation, organization: String?
    let education, experience, desc, smallImg: String?
    let largeImg: String?
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func scheduleTask(with url: URL, completionHandler: @escaping (ScheduleData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func personTask(with url: URL, completionHandler: @escaping (Executive?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
