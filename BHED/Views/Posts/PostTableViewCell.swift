//
//  PostTableViewCell.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import SnapKit

final class PostTableViewCell: UITableViewCell, ReusableView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var postLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "note")?.tintColor(.white)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        contentView.backgroundColor = .babylonPurple
        
        contentView.addSubview(postLogo)
        postLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(postLogo.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(postLogo.snp.centerY)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    func configure(forPost post: Post) {
        titleLabel.text = post.title
    }
}
