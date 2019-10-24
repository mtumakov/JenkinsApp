//
//  JobTableViewCell.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 14/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit

class JobTableViewCell: TableViewCell {
    var jobNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Some default text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        shadowedView.addSubview(jobNameLabel)
        print("job label added as subview of shadow view")
        setupLabelLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabelLayout() {
        jobNameLabel.topAnchor.constraint(equalTo: self.shadowedView.topAnchor, constant: 20).isActive = true
        jobNameLabel.leftAnchor.constraint(equalTo: self.shadowedView.leftAnchor, constant: 20).isActive = true
        jobNameLabel.rightAnchor.constraint(equalTo: self.shadowedView.rightAnchor, constant: 20).isActive = true
        jobNameLabel.bottomAnchor.constraint(equalTo: self.shadowedView.bottomAnchor)
    }
}
