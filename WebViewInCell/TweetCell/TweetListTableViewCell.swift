//
//  TweetListTableViewCell.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit
import WebKit

protocol TweetCellDelegate {
    func showResults()
}

class TweetListTableViewCell: UITableViewCell {
    static let identifier = "TweetListTableViewCell"
    static var delegate: TweetCellDelegate?
    
    static var rowIndex = 0
    static var instanceCount = 0
    
    @IBOutlet weak var webView: WKWebView!
    
    var height: CGFloat = 0 {
        didSet{
            TweetListTableViewCell.instanceCount += 1
            let webViewContraints = [
                self.webView.heightAnchor.constraint(equalToConstant: self.height)
            ]
            print("armut \(TweetListTableViewCell.instanceCount)")
            
            NSLayoutConstraint.activate(webViewContraints)
            
            if TweetListTableViewCell.instanceCount == Data.tweets.count {
                print("armut ayva")
                TweetListTableViewCell.delegate?.showResults()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.navigationDelegate = self
        // webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.loadHTMLString(Data.tweets[TweetListTableViewCell.rowIndex], baseURL: nil)
    } 
}

// MARK: - WK Navigation Delegate Methods
extension TweetListTableViewCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("armut suyu")
        // TODO: burası sıkıntılı yer 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.height = webView.scrollView.contentSize.height
        }
    }
}
