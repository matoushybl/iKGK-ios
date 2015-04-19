//
//  MainButton.swift
//  iKGK
//
//  Created by Matouš Hýbl on 17/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit

@objc(MainButton)
class MainButton: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    let overlayButton = UIButton()
    let separator = UIView()
    
    var title: String! {
        didSet {
            label.text = title
        }
    }
    
    var onClick: (() -> ())?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(label)
        addSubview(separator)
        addSubview(overlayButton)
        
        imageView.image = UIImage(named: "Image")
        overlayButton.addTarget(self, action: "onClicked", forControlEvents: .TouchUpInside)
        
        addConstraints()
    }
    
    func addConstraints() {
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
    
    func onClicked() {
        onClick?()
    }
}
