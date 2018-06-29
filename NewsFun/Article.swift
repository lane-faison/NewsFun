import Foundation
import DocumentClassifier

public struct Articles: Decodable {
    var articles: [Article]
    var totalResults: Int
    var status: String
    
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
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: Date?
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case urlString = "url"
        case urlToImageString = "urlToImage"
        case publishedAtString = "publishedAt"
    }
    
    public struct Source: Decodable {
        var id: String?
        var name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        source = try container.decode(Source.self, forKey: .source)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        if let urlString = try container.decodeIfPresent(String.self, forKey: .urlString) {
            url = URL(string: urlString)
        }
        if let urlToImageString = try container.decodeIfPresent(String.self, forKey: .urlToImageString) {
            urlToImage = URL(string: urlToImageString)
        }
        if let publishedAtString = try container.decodeIfPresent(String.self, forKey: .publishedAtString) {
            let dateFormatter = DateFormatter()
            publishedAt = dateFormatter.date(from: publishedAtString)
        }
        
        // CoreML implementation
        if let description = description, let title = title, let classification = DocumentClassifier().classify(title + description) {
            category = classification.prediction.category.rawValue
        }
    }
}
