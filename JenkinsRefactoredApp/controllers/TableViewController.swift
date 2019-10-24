//
//  TableViewController.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 11/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    var tableData = [Any]()
    let footerView = UIView(frame: CGRect.zero)
    
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TableViewCell.self, forCellReuseIdentifier: "cell")         // register cell name
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.estimatedRowHeight = 140
        return view
    }()
    
    lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    private func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func updateUI() {
        tableView.reloadData()
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Custom tableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableData.count == 0 {
            footerView.addSubview(activityView)
            activityView.startAnimating()
            
            NSLayoutConstraint(
                item: activityView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: footerView,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0.0
                ).isActive = true
            
            return footerView
        } else {
            return nil
        }
    }
}
