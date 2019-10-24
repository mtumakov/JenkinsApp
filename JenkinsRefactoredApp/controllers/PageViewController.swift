//
//  PageViewController.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 16/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit

class PageViewController: TableViewController {
    var folder: Folder? // Если выбрана папка
    var isMain = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "common cell")
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Registered JobTableViewCell")
        if isMain {
            print("\(Date().timeIntervalSince1970) - \(self.classForCoder): isMain is \(isMain)")
            getData()
        } else {
            print("\(Date().timeIntervalSince1970) - \(self.classForCoder): isMain is \(isMain), setting title")
            self.title = folder?.displayName
            
        }
    }
    
    init(jobs: [Job], page: Folder) {
        self.folder = page
        self.isMain = false
        super.init(nibName: nil, bundle: nil)
        self.tableData = jobs
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): custom init")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): default init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getData(with folder: Job? = nil) {
        let http: JenkinsApi = JenkinsApi()
        
        let stringUrl = folder?.url ?? "" // адрес сервера Jenkins
        
        guard let url = URL(string: "\(stringUrl)/api/json?pretty=true") else {
            return
        }
        
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): post url - \(url)")
        http.retrieveURL(url) {
            [unowned self] (data) -> Void in
            
            if let page = try? JSONDecoder().decode(MainPage.self, from: data) {
                print("\(Date().timeIntervalSince1970) - \(self.classForCoder): It is main page")
                self.tableData = page.jobs
//                self.title = page.nodeDescription
                self.title = "OSDO Jenkins"
                self.updateUI()
                return
            } else if let page = try? JSONDecoder().decode(Folder.self, from: data) {
                print("\(Date().timeIntervalSince1970) - \(self.classForCoder): it is folder")
                self.loadNextPage(page)
            } else if let page = try? JSONDecoder().decode(DetailedJob.self, from: data) {
                print("\(Date().timeIntervalSince1970) - \(self.classForCoder): it is detailed job")
                self.loadCollection(page)
            } else {
                print("Error: can't parse folder")
                return
            }
        }
    }
    
    func loadNextPage(_ page: Folder) {
        let folderViewController = PageViewController(jobs: page.jobs, page: page)
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Try to load FOlderViewController")
        navigationController?.pushViewController(folderViewController, animated: true)
    }
    
    func loadCollection(_ page: DetailedJob) {
        let jobViewController = DetailedPageViewController(page: page)
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Try to load JobViewController")
        navigationController?.pushViewController(jobViewController, animated: true)
    }
}

extension PageViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Table data count - \(tableData.count)")
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Let's create a cell")
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "common cell", for: indexPath) as! JobTableViewCell
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Let's create a job")
        let job = self.tableData[indexPath.row] as! Job
        print("\(Date().timeIntervalSince1970) - \(self.classForCoder): Binding job name")
        cell.jobNameLabel.text = job.name
//        cell.jobNameLabel.text = "Some\n Long text \n for view \n what \n i want to \n type \n fucking \n swift"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didDeselectRowAt: indexPath)
        getData(with: tableData[indexPath.row] as? Job)
    }
}
