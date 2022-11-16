//
//  TweetListTableViewCell.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit
import WebKit

class TweetListTableViewCell: UITableViewCell, WKNavigationDelegate {
    static let identifier = "TweetListTableViewCell"
    static var abc = 0
    
    @IBOutlet weak var webView: WKWebView!
    weak var delegate: ViewController?
    var indexPath: IndexPath!
    var height: CGFloat = 0 {
        didSet{
            let webViewContraints = [
                self.webView.heightAnchor.constraint(equalToConstant: self.height)
            ]
            DispatchQueue.main.async {
                NSLayoutConstraint.activate(webViewContraints)
                self.delegate?.tableView.reloadRows(at: [self.indexPath], with: .none)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.navigationDelegate = self
       // webView.uiDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.loadHTMLString(Data.tweets[TweetListTableViewCell.abc], baseURL: nil)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.height = webView.scrollView.contentSize.height
        }
    }
}
