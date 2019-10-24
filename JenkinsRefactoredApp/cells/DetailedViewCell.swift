//
//  DetailedViewCell.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 16/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit

class DetailedViewCell: TableViewCell {
    var displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Some default text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = customColor
        view.font = UIFont.systemFont(ofSize: 14)
        view.closestPosition(to: CGPoint(x: 0, y: 10))
        view.text = "Some default text"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        shadowedView.addSubview(displayNameLabel)
        shadowedView.addSubview(textView)
        print("job label added as subview of shadow view")
        setupLabelLayout()
        setupTextViewLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabelLayout() {
        displayNameLabel.topAnchor.constraint(equalTo: self.shadowedView.topAnchor, constant: 20).isActive = true
        displayNameLabel.leftAnchor.constraint(equalTo: self.shadowedView.leftAnchor, constant: 20).isActive = true
        displayNameLabel.rightAnchor.constraint(equalTo: self.shadowedView.rightAnchor, constant: -20).isActive = true
//        displayNameLabel.bottomAnchor.constraint(equalTo: self.shadowedView.bottomAnchor).isActive = true
    }
    
    private func setupTextViewLayout() {
        textView.topAnchor.constraint(equalTo: self.shadowedView.topAnchor, constant: 60).isActive = true
        textView.leftAnchor.constraint(equalTo: self.shadowedView.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: self.shadowedView.rightAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.shadowedView.bottomAnchor, constant: -20).isActive = true
    }
}
