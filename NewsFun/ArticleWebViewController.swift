import UIKit
import WebKit

class ArticleWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = article?.url else { return }
        
        webView.load(URLRequest(url: url))
    }
}
