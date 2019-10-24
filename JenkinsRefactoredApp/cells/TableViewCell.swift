//
//  TableViewCell.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 13/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit
import PureLayout

let customColor = UIColor(red: 0.956769, green: 0.956929, blue: 0.961053, alpha: 1)

class TableViewCell: UITableViewCell {
    var shadowedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = customColor
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        contentView.addSubview(shadowedView)
        setupLayout()
        shadowedView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: 5, height: 5), radius: 5, scale: true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func setupLayout() {
        shadowedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        shadowedView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        shadowedView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -16).isActive = true
        shadowedView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -16).isActive = true
    }
}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
