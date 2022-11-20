//
//  ChatViewController.swift
//  WebViewInCell
//
//  Created by Samet Koyuncu on 19.11.2022.
//

import UIKit
import WebKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var isReloadedOnce = false
    var reloadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(.init(nibName: ChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
}

// MARK: - table view delegate methods
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - table view datasource methods
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        
        cell.loadWebKit(str: Data.tweets[indexPath.row])
        cell.webView.tag = indexPath.row
        cell.webView.navigationDelegate = self
        return cell
    }
}

extension ChatViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if reloadCount < 3 {
            reloadCount += 1
            print("ayva ayva")
            tableView.reloadData()
        }
        
    }
}
