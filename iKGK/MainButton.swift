//
//  MainButton.swift
//  iKGK
//
//  Created by Matouš Hýbl on 17/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import SwiftKit

@objc(MainButton)
class MainButton: UIView {
    
    private var imageView: UIImageView!
    private var label: UILabel!
    private var overlayButton: UIButton!
    private var separator: UIView!
    
    var title: String! {
        didSet {
            label.text = title
        }
    }
    
    var onClick: Event<UIControl, UIEvent> {
        return overlayButton.touchUpInside
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        imageView => self
        label => self
        separator => self
        overlayButton => self
        
        // Wow. very name. such originality
        imageView.image = UIImage(named: "Image")
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        label.snp_remakeConstraints { make in
            make.height.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
        imageView.snp_remakeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        overlayButton.snp_remakeConstraints { make in
            make.edges.equalTo(self)
        }
        separator.snp_remakeConstraints { make in
            make.top.equalTo(self.snp_bottom).offset(-1)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
