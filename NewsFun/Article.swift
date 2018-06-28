import Foundation

public struct Articles: Decodable {
    var articles: [Article]
    var totalResults: Int
    
    public init?(json: JSON) {
        do {
            self = try JSONDecoder().decode(Articles.self, from: json.JSON())
        } catch {
            assertionFailure("There was an error parsing Articles")
            return nil
        }
    }
}

public struct Article: Decodable {
    var title: String?
    var author: String?
    var description: String
    var urlToImage: URL?
    var url: URL?
    var category: String?
    
    public init?(json: JSON) {
        do {
            self = try JSONDecoder().decode(Article.self, from: json.JSON())
        } catch {
            assertionFailure("There was an error parsing Articles")
            return nil
        }
    }
}
