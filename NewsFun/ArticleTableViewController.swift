import UIKit
import Kingfisher

class ArticleTableViewController: UITableViewController {
    
    var articles: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getArticles()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
    }
    
    private func getArticles() {
        NewsHelper().getArticles { articles in
            self.articles = articles
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.articles.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell,
            let article = articles?.articles[indexPath.row] {
            
            cell.titleLabel.text = article.title
            cell.categoryLabel.text = article.category.rawValue
            cell.categoryLabel.backgroundColor = article.categoryColor
            
            let placeholderImage = UIImage(named: "newspaper")
            
            if let url = article.urlToImage {
                cell.articleImageView.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                cell.articleImageView.image = placeholderImage
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = articles?.articles[indexPath.row] else { return }
        
        performSegue(withIdentifier: "goToUrl", sender: article)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToUrl",
            let article = sender as? Article,
            let webVC = segue.destination as? ArticleWebViewController else { return }
        webVC.article = article
    }
    
    @IBAction func reloadTapped(_ sender: Any) {
        getArticles()
    }
}
