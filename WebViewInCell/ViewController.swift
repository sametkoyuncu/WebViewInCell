//
//  ViewController.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit

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
        TweetListTableViewCell.delegate = self
        
        tableView.isHidden = true
        
        tableView.register(.init(nibName: "TweetListTableViewCell", bundle: nil), forCellReuseIdentifier: TweetListTableViewCell.identifier)
    }
}

// MARK: - TableView Delegate Methods
extension ViewController: UITableViewDelegate { }

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // for using tweet index
        // TODO: burası sıkıntılı yer 1
        TweetListTableViewCell.rowIndex = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetListTableViewCell.identifier, for: indexPath) as! TweetListTableViewCell
      
        return cell
    }
}

extension ViewController: TweetCellDelegate {
    func showResults() {
        tableView.reloadData()
        tableView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}


