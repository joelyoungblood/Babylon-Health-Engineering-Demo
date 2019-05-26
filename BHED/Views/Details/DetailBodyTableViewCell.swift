//
//  DetailBodyTableViewCell.swift
//  BHED
//
//  Created by Joel Youngblood on 5/25/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

final class DetailBodyTableViewCell: UITableViewCell, ReusableView {
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        
        contentView.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(forBodyString string: String) {
        bodyLabel.text = string
    }
}
