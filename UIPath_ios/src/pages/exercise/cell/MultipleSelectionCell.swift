//
//  MultipleSelectionCell.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MultipleSelectionCell: MultipleCell {
    lazy var resultBtn = UIButton()
    lazy var resultIconView = UIImageView()
    lazy var answerLbl = UILabel()
    
    override class var id : String {
        return "MultipleSelectionCell"
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
        resultBtn.setBackgroundImage(UIImage.from(color: UIColor.orange), for: .normal)
        resultBtn.setBackgroundImage(UIImage.from(color: UIColor.lightGray), for: .highlighted)
        resultBtn.layer.cornerRadius = 12
        resultBtn.clipsToBounds = true
        resultBtn.setTitle("確認", for: .normal)
        self.contentView.addSubview(resultBtn)
        
        resultIconView.contentMode = .scaleAspectFit
        resultIconView.clipsToBounds = true
        resultIconView.isHidden = true
        self.contentView.addSubview(resultIconView)
        
        answerLbl.textColor = UIColor.red
        answerLbl.font = UIFont.systemFont(ofSize: 16)
        answerLbl.textAlignment = .left
        answerLbl.numberOfLines = 0
        answerLbl.isHidden = true
        self.contentView.addSubview(answerLbl)
        
        resultBtn.snp.makeConstraints { make in
            make.top.equalTo(option4Lbl.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        resultIconView.snp.makeConstraints { make in
            make.top.equalTo(resultBtn.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        answerLbl.snp.makeConstraints { make in
            make.top.equalTo(resultIconView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        btns = [check1Btn, check2Btn, check3Btn]
        optionLbls = [option1Lbl, option2Lbl, option3Lbl]
    }
    
    override func configure(with data: ExerciseData) {
        super.configure(with: data)
        // bind.
        data.selection.asObservable().bind { [weak self] values in
            if values.count == 0 {
                self?.answerLbl.isHidden = true
            }
        }.disposed(by: disposeBag)
        
        resultBtn.rx.tap.bind { [weak self] in
            self?.resultIconView.isHidden = false
            
            // 結果を表示する.
            let result = data.selection.value.sorted(by: <).map{"\($0)"}.joined(separator: ",")
            if result == data.answer {
                // 回答正确.
                self?.answerLbl.isHidden = true
                self?.resultIconView.image = correctIcon
            } else {
                // 回答错误.
                self?.answerLbl.isHidden = false
                self?.resultIconView.image = wrongIcon
            }
        }.disposed(by: disposeBag)
        
        // 设定正确回答.
        let answers = data.answer.split(separator: ",")
        var result = "正解は："
        for answer in answers {
            guard let value = Int(answer) else {continue}
            
            if value >= optionLbls.count {
                continue
            }
            guard let text = optionLbls[value].text else {continue}
            result = result + "\n\(text)"
        }
        answerLbl.text = result
    }
}
