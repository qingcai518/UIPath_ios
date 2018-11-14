//
//  ResultCell.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    lazy var questionMark = UIImageView()
    lazy var answerMark = UIImageView()
    lazy var resultMark = UIImageView()
    lazy var questionLbl = UILabel()
    lazy var resultLbl = UILabel()
    lazy var answerLbl = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resultMark.image = nil
        questionLbl.text = nil
        resultLbl.text = nil
        answerLbl.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        questionMark.contentMode = .scaleAspectFit
        questionMark.clipsToBounds = true
        questionMark.image = questionIcon
        self.contentView.addSubview(questionMark)
        
        answerMark.contentMode = .scaleAspectFit
        answerMark.clipsToBounds = true
        answerMark.image = answerIcon
        self.contentView.addSubview(answerMark)
        
        resultMark.contentMode = .scaleAspectFit
        resultMark.clipsToBounds = true
        self.contentView.addSubview(resultMark)
        
        questionLbl.textColor = UIColor.black
        questionLbl.font = UIFont.systemFont(ofSize: 16)
        questionLbl.backgroundColor = UIColor.orange
        questionLbl.numberOfLines = 0
        self.contentView.addSubview(questionLbl)
        
        answerLbl.textColor = UIColor.black
        answerLbl.font = UIFont.systemFont(ofSize: 16)
        answerLbl.numberOfLines = 0
        self.contentView.addSubview(answerLbl)
        
        resultLbl.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(resultLbl)
        
        questionMark.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
        
        questionLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalTo(questionMark.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        resultMark.snp.makeConstraints { make in
            make.top.equalTo(questionLbl.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24 + 24 + 40)
            make.right.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
        
        resultLbl.snp.makeConstraints { make in
            make.top.equalTo(questionLbl.snp.bottom).offset(24)
            make.left.equalTo(resultMark.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        answerMark.snp.makeConstraints { make in
            make.top.equalTo(resultLbl.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24 + 24 + 40)
            make.right.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
        
        answerLbl.snp.makeConstraints { make in
            make.top.equalTo(resultLbl.snp.bottom).offset(24)
            make.left.equalTo(answerMark.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
        }
    }
    
    func configure(with data: ExerciseData) {
        let sorted = data.selection.value.sorted(by: <)
        let selection = sorted.map{"\($0)"}.joined(separator: ",")
        let answer = data.answer
        if selection == answer {
            resultMark.image = correctIcon
        } else {
            resultMark.image = wrongIcon
        }
        
        // 设置用户选择的答案.
        let options = [data.option1, data.option2, data.option3, data.option4]
        var result = ""
        for index in sorted {
            let option = options[index]
            result += "\(option)\n"
        }
        resultLbl.text = result
        
        // 设置标准答案.
        var answers = ""
        let indexes = data.answer.split(separator: ",")
        for indexStr in indexes {
            guard let index = Int(indexStr) else {continue}
            if index >= options.count {continue}
            let answer = options[index]
            answers += "\(answer)\n"
        }
        self.answerLbl.text = answers
        
        // 设置问题.
        self.questionLbl.text = data.question
    }
}
