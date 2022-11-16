//
//  TweetListTableViewCell.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit
import WebKit

class TweetListTableViewCell: UITableViewCell, WKNavigationDelegate, WKUIDelegate {
    static let identifier = "TweetListTableViewCell"
    static var abc = 0
    
    @IBOutlet weak var webView: WKWebView!
    weak var delegate: ViewController?
    var indexPath: IndexPath!
    var height: CGFloat = 0 {
        didSet{
            let webViewContraints = [
                webView.heightAnchor.constraint(equalToConstant: height)
            ]
            
            NSLayoutConstraint.activate(webViewContraints)
            DispatchQueue.main.async {
                self.delegate?.tableView.reloadRows(at: [self.indexPath], with: .none)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.navigationDelegate = self
        webView.uiDelegate = self
          
        webView.translatesAutoresizingMaskIntoConstraints = false
       // webView.scrollView.isScrollEnabled = false
        
        webView.loadHTMLString(Data.tweets[TweetListTableViewCell.abc], baseURL: nil)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.height = webView.scrollView.contentSize.height
            print("finished loading: height=\(webView.scrollView.contentSize.height)")
        }
    }
}
