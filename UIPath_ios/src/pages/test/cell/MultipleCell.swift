//
//  MultipleCell.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

import UIKit
import RxSwift
import RxCocoa

class MultipleCell: UICollectionViewCell {
    static let id = "MultipleSelectionCell"
    lazy var questionLbl = UILabel()
    lazy var check1Btn = UIButton()
    lazy var check2Btn = UIButton()
    lazy var check3Btn = UIButton()
    lazy var option1Lbl = UILabel()
    lazy var option2Lbl = UILabel()
    lazy var option3Lbl = UILabel()
    
    lazy var resultBtn = UIButton()
    lazy var resultIconView = UIImageView()
    lazy var answerLbl = UILabel()
    
    var disposeBag = DisposeBag()
    
    lazy var btns = [UIButton]()
    lazy var optionLbls = [UILabel]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLbl.text = nil
        option1Lbl.text = nil
        option2Lbl.text = nil
        option3Lbl.text = nil
        resultIconView.image = nil
        answerLbl.text = nil
        
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        questionLbl.textColor = UIColor.black
        questionLbl.textAlignment = .left
        questionLbl.font = UIFont.systemFont(ofSize: 16)
        questionLbl.numberOfLines = 0
        self.contentView.addSubview(questionLbl)
        
        check1Btn.setImage(uncheckIcon, for: .normal)
        self.contentView.addSubview(check1Btn)
        
        option1Lbl.textColor = UIColor.black
        option1Lbl.textAlignment = .left
        option1Lbl.font = UIFont.systemFont(ofSize: 16)
        option1Lbl.numberOfLines = 0
        self.contentView.addSubview(option1Lbl)
        
        check2Btn.setImage(uncheckIcon, for: .normal)
        self.contentView.addSubview(check2Btn)
        
        option2Lbl.textColor = UIColor.black
        option2Lbl.textAlignment = .left
        option2Lbl.font = UIFont.systemFont(ofSize: 16)
        option2Lbl.numberOfLines = 0
        self.contentView.addSubview(option2Lbl)
        
        check3Btn.setImage(uncheckIcon, for: .normal)
        self.contentView.addSubview(check3Btn)
        
        option3Lbl.textColor = UIColor.black
        option3Lbl.textAlignment = .left
        option3Lbl.font = UIFont.systemFont(ofSize: 16)
        option3Lbl.numberOfLines = 0
        self.contentView.addSubview(option3Lbl)
        
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
        
        questionLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.left.right.equalToSuperview().inset(24)
        }
        
        check1Btn.snp.makeConstraints { make in
            make.top.equalTo(questionLbl.snp.bottom).offset(44)
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
        
        option1Lbl.snp.makeConstraints { make in
            make.top.equalTo(questionLbl.snp.bottom).offset(44)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(check1Btn.snp.right).offset(24)
        }
        
        check2Btn.snp.makeConstraints { make in
            make.top.equalTo(option1Lbl.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
        
        option2Lbl.snp.makeConstraints { make in
            make.top.equalTo(option1Lbl.snp.bottom).offset(24)
            make.left.equalTo(check2Btn.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        check3Btn.snp.makeConstraints { make in
            make.top.equalTo(option2Lbl.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
        
        option3Lbl.snp.makeConstraints { make in
            make.top.equalTo(option2Lbl.snp.bottom).offset(24)
            make.left.equalTo(check3Btn.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
        }
        
        resultBtn.snp.makeConstraints { make in
            make.top.equalTo(option3Lbl.snp.bottom).offset(24)
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
    
    func configure(with data: ExerciseData) {
        questionLbl.text = data.question
        option1Lbl.text = data.option1
        option2Lbl.text = data.option2
        option3Lbl.text = data.option3
        
        // bind.
        data.selection.asObservable().bind { [weak self] values in
            guard let `self` = self else {return}
            
            if values.count == 0 {
                self.answerLbl.isHidden = true
            }
            
            // 首先清除所有的选择.
            let _ = self.btns.map{$0.setImage(uncheckIcon, for: .normal)}
            
            // 重新选择.
            for i in values {
                if i >= self.btns.count {continue}
                self.btns[i].setImage(checkIcon, for: .normal)
            }
            }.disposed(by: disposeBag)
        
        // tap event.
        for i in 0..<btns.count {
            btns[i].rx.tap.bind { [weak self] in
                self?.doSelect(element: i, data: data)
                }.disposed(by: disposeBag)
            
            let recognizer = UITapGestureRecognizer()
            recognizer.rx.event.bind { [weak self] sender in
                self?.doSelect(element: i, data: data)
                }.disposed(by: disposeBag)
            optionLbls[i].isUserInteractionEnabled = true
            optionLbls[i].addGestureRecognizer(recognizer)
        }
        
        resultBtn.rx.tap.bind { [weak self] in
            self?.resultIconView.isHidden = false
            
            // 結果を表示する.
            let values = data.selection.value
            let valueArray = values.map{"\($0)"}
            
            let result = valueArray.joined(separator: ",")
            
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
    
    private func doSelect(element : Int, data : ExerciseData) {
        if let index = data.selection.value.firstIndex(of: element) {
            data.selection.value.remove(at: index)
        } else {
            data.selection.value.append(element)
        }
    }
}
