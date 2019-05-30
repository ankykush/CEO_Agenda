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
}


struct Schedule: Codable {
    let meeting, place, time, longTime: String
    let desc, name: String
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

struct PeopleArray: Codable {
    let tcsPeople, usaaPeople: [Person]
    
    enum CodingKeys: String, CodingKey {
        case tcsPeople = "TCSPeopleArray"
        case usaaPeople = "USAAPeopleArray"
    }
}

struct Person: Codable {
    let name, nickName, designation: String
    let organization: Organization
    let education: String
    let experience: Experience
    let desc, smallImg, largeImg: String
    
    
}

enum Experience: String, Codable {
    case empty = ""
    case over20Years = "Over 20 years"
}

enum Organization: String, Codable {
    case tcs = "TCS"
    case usaa = "USAA"
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
    
    func personTask(with url: URL, completionHandler: @escaping (PeopleArray?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
