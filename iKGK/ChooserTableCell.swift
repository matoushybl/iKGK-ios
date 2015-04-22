//
//  ChooserTableCell.swift
//  iKGK
//
//  Created by Matouš Hýbl on 20/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit

class ChooserTableCell: UITableViewCell {
    
    let label = UILabel()
    let arrow = UIImageView()
    
    var title: String! {
        didSet {
            label.text = title
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        addSubview(arrow)
        addSubview(label)
        arrow.image = UIImage(named: "Image")
        label.snp_remakeConstraints { make in
            make.height.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
        arrow.snp_remakeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}
