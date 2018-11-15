//
//  SingleSelectionCell.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SingleSelectionCell: SingleCell {
    lazy var resultIconView = UIImageView()
    lazy var answerLbl = UILabel()
    
    override class var id : String {
        return "SingleSelectionCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resultIconView.image = nil
        answerLbl.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        resultIconView.contentMode = .scaleAspectFit
        resultIconView.clipsToBounds = true
        resultIconView.isHidden = true
        self.contentView.addSubview(resultIconView)
        
        answerLbl.textColor = UIColor.red
        answerLbl.numberOfLines = 0
        answerLbl.font = UIFont.systemFont(ofSize: 16)
        answerLbl.isHidden = true
        self.contentView.addSubview(answerLbl)
        
        resultIconView.snp.makeConstraints { make in
            make.top.equalTo(option4Lbl.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        answerLbl.snp.makeConstraints { make in
            make.top.equalTo(resultIconView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    override func configure(with data: ExerciseData) {
        super.configure(with: data)
        
        // bind.
        data.selection.asObservable().bind { [weak self] values in
            guard let `self` = self else {return}
            
            guard let value = values.first else {
                let _ = self.btns.map{$0.setImage(radioUncheckIcon, for: .normal)}
                self.answerLbl.isHidden = true
                return
            }
            
            self.resultIconView.isHidden = false
            if "\(value)" == data.answer {
                // 回答正确.
                self.answerLbl.isHidden = true
                self.resultIconView.image = correctIcon
            } else {
                // 回答错误.
                self.answerLbl.isHidden = false
                self.resultIconView.image = wrongIcon
            }
        }.disposed(by: disposeBag)

        // answer.
        var correct = "正解は："
        let answers = data.answer.split(separator: ",")
        for answer in answers {
            guard let index = Int(answer) else {return}
            if index < optionLbls.count {
                guard let text = optionLbls[index].text else {continue}
                correct += "\n\(text)"
            }
        }
        answerLbl.text = correct
    }
}
