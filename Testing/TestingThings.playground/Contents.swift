//
//import Foundation
//
//protocol Parseable {
//    static func from(any: Any) throws -> Self
//}
//
//enum ParseableError: ErrorType {
//    case RequiredFieldsNotFound(String)
//}
//
//protocol Response: Parseable {
//    
//}
//
//protocol PagedFilmListResponse: Response {
//
//    typealias FilmType: Parseable
//
//    var page: Int { get }
//    var films: [FilmType] { get }
//
//    init(page: Int, films: [FilmType])
//}
//
//extension PagedFilmListResponse {
//
//    // MARK: - Parseable
//    static func from(any: Any) throws -> Self {
//
//        let dictionary = any as! Dictionary<String, AnyObject>
//        guard
//            let page = dictionary[PagedFilmListResponseFields.Page] as? Int,
//            let results = dictionary[PagedFilmListResponseFields.Results] as? [Dictionary<String, AnyObject>]
//            else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
//
//        let films = results.flatMap { (value: Dictionary<String, AnyObject>) -> FilmType? in
//            do {
//                return try FilmType.from(any: value)
//            } catch {
//
//            }
//            return nil
//        }
//        return self.init(page: page, films: films)
//    }
//
//}
//
//private struct PagedFilmListResponseFields {
//    static let Page = "page"
//    static let Results = "results"
//}
//
//struct Object: Parseable {
//    let name = "Object"
//    static func from(any: Any) throws -> Object {
//        return Object()
//    }
//}
//
//struct AResponse: PagedFilmListResponse {
//    typealias FilmType = Object
//    
//    let page:Int
//    let films: [FilmType]
//
//    init(page: Int, films: [FilmType]) {
//        self.page = page
//        self.films = films
//    }
//}
//
//
//
//var dic: NSDictionary = ["page" : 1, "results": ["" : "", "": ""]]
//
//do {
//    try AResponse.from(dic)
//} catch let error {
//    error
//}
//
//

struct Object: CustomStringConvertible {
    let name: String
    var things: [String]?
    
    var description: String {
        get {
            return "name: \(self.name) things \(self.things)"
        }
    }
    
    init (name: String) {
        self.name = name
    }
    
}


var object = Object(name: "hola")
object.things = ["que", "coño", "pasa"]

let mutated = object






