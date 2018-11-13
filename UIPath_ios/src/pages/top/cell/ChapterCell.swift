//
//  ChapterCell.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

class ChapterCell: TableViewCell {
    static let id = "ChapterCell"
    let nameLbl = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLbl.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        nameLbl.textColor = UIColor.black
        nameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        nameLbl.numberOfLines = 1
        
        self.contentView.addSubview(nameLbl)
        
        nameLbl.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    func configure(with data: ChapterData) {
        self.nameLbl.text = data.name
    }
    
    func configure(with name: String) {
        self.nameLbl.text = name
    }
}
