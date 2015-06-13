//
//  ChooserTableCell.swift
//  iKGK
//
//  Created by Matouš Hýbl on 20/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import SwiftKit

class ChooserTableCell: UITableViewCell {
    
    private var label: UILabel!
    private var arrow: UIImageView!
    
    var title: String! {
        didSet {
            label.text = title
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        arrow => self
        label => self
        
        arrow.image = UIImage(named: "Image")
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
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
