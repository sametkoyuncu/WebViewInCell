//
//  ChatViewController.swift
//  WebViewInCell
//
//  Created by Samet Koyuncu on 19.11.2022.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
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
        400
    }
}

// MARK: - table view datasource methods
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        
        cell.loadWebKit(str: "<meta name='viewport' content='initial-scale=1.0'/><blockquote class='twitter-tweet'><p lang='tr' dir='ltr'>Teknoloji alanında yurtdışında staj yapmak isteyen arkadaşlar, 2023 yılı yazı için stajyer alımı yapan teknoloji şirketlerinin listesine şuradan ulaşabilirsiniz: <a href='https://t.co/zI8DzIKJZI'>https://t.co/zI8DzIKJZI</a></p>&mdash; Fatih Yavuz (@fthdev) <a href='https://twitter.com/fthdev/status/1592807393985204224?ref_src=twsrc%5Etfw'>November 16, 2022</a></blockquote> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>")
        return cell
    }
}
