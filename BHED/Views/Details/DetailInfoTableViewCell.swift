//
//  DetailDetailsTableViewCell.swift
//  BHED
//
//  Created by Joel Youngblood on 5/25/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

final class DetailInfoTableViewCell: UITableViewCell, ReusableView {
    
    private lazy var authorTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.text = "Author"
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
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
        
        contentView.addSubview(authorTitle)
        authorTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(authorTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(withUser user: User?, withCommentCount count: Int?) {
        authorLabel.text = user?.name ?? "Unknown"
        commentLabel.text = "\(count ?? 0) total comments"
    }
}
