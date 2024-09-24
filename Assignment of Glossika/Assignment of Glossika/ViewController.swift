//
//  ViewController.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let tableViewIdentifier = "tableViewIdentifier"
    private let rowHeight = 200.0

    let dataSource: [[UIImage]] = [
        [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!],
        [UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!],
        [UIImage(named: "image2")!, UIImage(named: "image2")!, UIImage(named: "image2")!]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.configure(with: dataSource[indexPath.section])
        return cell
    }
}
