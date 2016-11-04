//
//  MenuViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit

final class MenuViewController: UITableViewController {
    fileprivate let reuseIdentifier = "Cell"
    fileprivate let cells: [(title: String, color: UIColor)] = [("simple", .green), ("gesture", .red),]
    private var cellHeight: CGFloat {
        return tableView.bounds.height / CGFloat(cells.count)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = cellHeight
        tableView.estimatedRowHeight = cellHeight
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = cells[indexPath.row].title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 48)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = cells[indexPath.row].color
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard.main
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NaviScene")
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        case 1:
            UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: GestureViewController.create())
        default:
            break
        }
    }
}
