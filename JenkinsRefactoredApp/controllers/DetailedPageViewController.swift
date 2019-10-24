//
//  DetailedPageViewController.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 15/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit

class DetailedPageViewController: TableViewController {
    var builds = [Build]()
    let page: DetailedJob
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DetailedViewCell.self, forCellReuseIdentifier: "detailedCell")
        tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "commonCell")
        self.title = page.displayName
    }
    
    init(page: DetailedJob) {
        self.page = page
        self.builds = page.builds
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requestToken(build: Build) {
        let viewController = WebViewController(build: build)
        present(viewController, animated: false, completion: nil)
    }
}

extension DetailedPageViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return builds.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "detailedCell", for: indexPath) as! DetailedViewCell
            cell.displayNameLabel.text = page.displayName
            cell.textView.text = "Some text about this Job"
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "commonCell", for: indexPath) as! JobTableViewCell
            print("Current index - \(indexPath.row)")
            print("New index - \(indexPath.row - 1)")
            print("builds count - \(builds.count)")
            let build = self.builds[indexPath.row - 1] as? Build
            cell.jobNameLabel.text = "Сборка №\(build!.number)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 280
        } else {
            return 140
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            super.tableView(tableView, didDeselectRowAt: indexPath)
            print("row number - \(indexPath.row)")
            print("table data count - \(builds.count)")
            requestToken(build: builds[indexPath.row - 1])
        }
    }
}
