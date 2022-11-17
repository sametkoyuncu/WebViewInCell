//
//  ViewController.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var webView: WKWebView!
    var webView2: ArticleWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  configureWebView()
        setupTableView()
    }
    
    func configureWebView() {
        let config = WKWebViewConfiguration()
        //let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
    //let source = "document.onreadystatechange = function(){ if(document.readyState) === 'complete'){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight)}}"
      //  let source = "document.onreadystatechange = function(){ if(document.readyState) === 'complete'){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight)}}"
       let source = "var interval = setInterval(function() {if(document.readyState === 'complete') { clearInterval(interval); window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight)}}, 100);"
       // let source = "window.addEventListener('load', function() { window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); })"
       // let source = "window.addEventListener('load', function(){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); })"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
        config.userContentController.add(self, name: "iosListener")
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // for showing results
        
        tableView.isHidden = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - TableView Delegate Methods
extension ViewController: UITableViewDelegate {

}

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        webView2 = ArticleWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        cell.contentView.addSubview(webView2)
        
        webView2.reloadRow = {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        let webViewContraints = [
            webView2.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 0),
            webView2.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 0),
            webView2.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            webView2.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0),
            webView2.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(webViewContraints)
        
        webView2.loadHTMLString(Data.tweets[indexPath.row], baseURL: nil)
        
        return cell
    }
}

// MARK: - wk
extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message: \(message.body)")
    }
}

