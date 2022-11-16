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
            self.delegate?.tableView.reloadRows(at: [self.indexPath], with: .none)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        let tweets = [
            "<meta name='viewport' content='initial-scale=1.0'/><blockquote class='twitter-tweet'><p lang='tr' dir='ltr'>Teknoloji alanında yurtdışında staj yapmak isteyen arkadaşlar, 2023 yılı yazı için stajyer alımı yapan teknoloji şirketlerinin listesine şuradan ulaşabilirsiniz: <a href='https://t.co/zI8DzIKJZI'>https://t.co/zI8DzIKJZI</a></p>&mdash; Fatih Yavuz (@fthdev) <a href='https://twitter.com/fthdev/status/1592807393985204224?ref_src=twsrc%5Etfw'>November 16, 2022</a></blockquote> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>",
            "<meta name='viewport' content='initial-scale=1.0'/><blockquote class='twitter-tweet'><p lang='zxx' dir='ltr'><a href='https://t.co/EHRhcUhwFA'>pic.twitter.com/EHRhcUhwFA</a></p>&mdash; Mizah desen var (@mizahdesen) <a href='https://twitter.com/mizahdesen/status/1592778906331119616?ref_src=twsrc%5Etfw'>November 16, 2022</a></blockquote> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>",
            "<meta name='viewport' content='initial-scale=1.0'/><blockquote class='twitter-tweet'><p lang='en' dir='ltr'>We’re building for the future, for better devex &amp; productivity.<br><br>Today, we are excited to announce Console 2.0, our new dashboard, completely reimagined from the ground up.<br><br>Join us NOW on Product Hunt👇🏻<a href='https://t.co/y5xKfW15Pw'>https://t.co/y5xKfW15Pw</a></p>&mdash; Appwrite (@appwrite) <a href='https://twitter.com/appwrite/status/1592566862956711937?ref_src=twsrc%5Etfw'>November 15, 2022</a></blockquote> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>",
        ]
        webView.translatesAutoresizingMaskIntoConstraints = false
       // webView.scrollView.isScrollEnabled = false
        
        webView.loadHTMLString(tweets[2], baseURL: nil)
        
        TweetListTableViewCell.abc += 1
    
        
        
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.height = webView.scrollView.contentSize.height
            print("finished loading: height=\(webView.scrollView.contentSize.height)")
        }
        
    }
    
}
