//
//  ChatTableViewCell.swift
//  WebViewInCell
//
//  Created by Samet Koyuncu on 19.11.2022.
//

import UIKit
import WebKit
class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadWebKit(str: String) {
        webView.loadHTMLString(str, baseURL: nil)
    }
    
}
