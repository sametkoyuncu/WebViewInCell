//
//  ViewController.swift
//  WebViewInCell
//
//  Created by fmss on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
   

    @IBOutlet weak var tableView: UITableView!
    
    var rowHeight: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(.init(nibName: "TweetListTableViewCell", bundle: nil), forCellReuseIdentifier: TweetListTableViewCell.identifier)
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
        TweetListTableViewCell.abc = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetListTableViewCell.identifier, for: indexPath) as! TweetListTableViewCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}



