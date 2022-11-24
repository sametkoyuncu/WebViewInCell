//
//  ViewController.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(.init(nibName: "TweetListTableViewCell", bundle: nil), forCellReuseIdentifier: TweetListTableViewCell.identifier)
    }
}

// MARK: - TableView Delegate Methods
extension ViewController: UITableViewDelegate { }

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? TweetListTableViewCell {
            return cell.webView.scrollView.contentSize.height
        }
        return UITableView.automaticDimension
    }
    
//    ??
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetListTableViewCell.identifier, for: indexPath) as! TweetListTableViewCell
        
        cell.configureCell(for: self, with: Data.tweets[indexPath.row])
        
        return cell
    }
}

extension ViewController: TweetCellDelegate {
    func updateHeights() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
