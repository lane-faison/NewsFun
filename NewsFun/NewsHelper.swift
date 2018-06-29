import Foundation
import Alamofire

class NewsHelper {
    
    func getArticles() {
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=dce0ac82107c442b9d83f38350d2fcc9").responseJSON { (response) in
            if let articlesJSON = response.result.value as? JSON {
                guard let articles = Articles(json: articlesJSON) else { return }
                
            }
        }
    }
}
