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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // for showing results
        
        tableView.isHidden = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureWebView() -> WKWebView {
        let config = WKWebViewConfiguration()
        // MARK: let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); })"
        // TODO: let source = "var interval = setInterval(function() {if(document.readyState === 'complete') { clearInterval(interval); window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight)}}, 100);"
        
        //  let source = "document.onreadystatechange = function(){ if (document.readyState === 'complete') { window.webkit.messageHandlers.iosListener.postMessage('if: ' + document.body.scrollHeight); } else { window.onload = function () { window.webkit.messageHandlers.iosListener.postMessage('else: ' + document.body.scrollHeight); }; }; }"
        // let source = "const observer = new ResizeObserver(entries => { for (const entry of entries) { window.webkit.messageHandlers.iosListener.postMessage(entry.contentRect.height) } }) observer.observe(document.querySelector('body'))"
        //let source = "window.watch('document.body.clientHeight', function() { window.webkit.messageHandlers.iosListener.postMessage(document.body.clientHeight) });"
        let source = """
                    window.onload = function() {
                                                                                                      inwindow.webkit.messageHandlers.iosListener.postMessage(document.body.clientHeight)
                    }
"""
        
        //let source = "window.onload = function() {const resizeObserver = new ResizeObserver(entries => window.webkit.messageHandlers.iosListener.postMessage(entries[0].target.clientHeight)) resizeObserver.observe(document.body)}"
        //let source = "document.onreadystatechange = function(){ if(document.readyState) === 'complete'){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight)}}"
        // let source = "window.onload = function() { window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); }"
        //     let source = "window.addEventListener('load', function() { window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); }, false)"
        //let source = "document.addEventListener('loaded', function(){ window.webkit.messageHandlers.iosListener.postMessage(document.body.scrollHeight); })"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
        config.userContentController.add(self, name: "iosListener")
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }
}

// MARK: - TableView Delegate Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let webView = configureWebView()
        cell.contentView.addSubview(webView)
        
        //        webView.reloadRow = {
        //            self.tableView.reloadRows(at: [indexPath], with: .none)
        //        }
        
        let webViewContraints = [
            webView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 0),
            webView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            webView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(webViewContraints)
        
        webView.loadHTMLString(Data.tweets[indexPath.row], baseURL: nil)
        
        return cell
    }
}

// MARK: - wk
extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message: \(message.body)")
    }
}



