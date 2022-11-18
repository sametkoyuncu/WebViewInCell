//
//  TweetView.swift
//  WebViewInCell
//
//  Created by Samet Koyuncu on 17.11.2022.
//

import UIKit
import WebKit

class ArticleWebView: WKWebView {
    var isReloadCalled = false
    var reloadRow: (()->())?

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        
   // let configuration = WKWebViewConfiguration()
    super.init(frame: frame, configuration: configuration)
    self.navigationDelegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var intrinsicContentSize: CGSize {
      print("elma")
    return self.scrollView.contentSize
  }
}

extension ArticleWebView: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (result, _) in
        print("elma sametk \(webView.scrollView.contentSize.height) \(result)")
        let webViewContraints = [
            webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height)
        ]
        NSLayoutConstraint.activate(webViewContraints)
        webView.invalidateIntrinsicContentSize()
//        if self.isReloadCalled == false {
//            self.isReloadCalled = true
//            print("elma can")
//            self.reloadRow?()
//        }
        
        print("elma sametk")
    })
  }
}

extension ArticleWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message: \(message.body)")
    }
}
