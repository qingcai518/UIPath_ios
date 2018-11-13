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

class SingleSelectionCell: UICollectionViewCell {
    static let id = "SingleSelectionCell"
    lazy var questionLbl = UILabel()
    lazy var check1Btn = UIButton()
    lazy var check2Btn = UIButton()
    lazy var check3Btn = UIButton()
    lazy var option1Lbl = UILabel()
    lazy var option2Lbl = UILabel()
    lazy var option3Lbl = UILabel()
    
    lazy var resultIconView = UIImageView()
    lazy var resultLbl = UILabel()
    lazy var answerLbl = UILabel()
    
    var btns = [UIButton]()
    var optionLbls = [UILabel]()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLbl.text = nil
        option1Lbl.text = nil
        option2Lbl.text = nil
        option3Lbl.text = nil
        
        resultIconView.image = nil
        resultLbl.text = nil
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
        
        check1Btn.setImage(radioUncheckIcon, for: .normal)
        self.contentView.addSubview(check1Btn)
        
        option1Lbl.textColor = UIColor.black
        option1Lbl.textAlignment = .left
        option1Lbl.font = UIFont.systemFont(ofSize: 16)
        option1Lbl.numberOfLines = 0
        self.contentView.addSubview(option1Lbl)
        
        check2Btn.setImage(radioUncheckIcon, for: .normal)
        self.contentView.addSubview(check2Btn)
        
        option2Lbl.textColor = UIColor.black
        option2Lbl.textAlignment = .left
        option2Lbl.font = UIFont.systemFont(ofSize: 16)
        option2Lbl.numberOfLines = 0
        self.contentView.addSubview(option2Lbl)
        
        check3Btn.setImage(radioUncheckIcon, for: .normal)
        self.contentView.addSubview(check3Btn)
        
        option3Lbl.textColor = UIColor.black
        option3Lbl.textAlignment = .left
        option3Lbl.font = UIFont.systemFont(ofSize: 16)
        option3Lbl.numberOfLines = 0
        self.contentView.addSubview(option3Lbl)
        
        resultIconView.contentMode = .scaleAspectFit
        resultIconView.clipsToBounds = true
        resultIconView.isHidden = true
        self.contentView.addSubview(resultIconView)
        
        resultLbl.textAlignment = .left
        resultLbl.font = UIFont.boldSystemFont(ofSize: 16)
        resultLbl.isHidden = true
        self.contentView.addSubview(resultLbl)
        
        answerLbl.textColor = UIColor.red
        answerLbl.numberOfLines = 0
        answerLbl.font = UIFont.systemFont(ofSize: 16)
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
        
        resultIconView.snp.makeConstraints { make in
            make.top.equalTo(option3Lbl.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.height.width.equalTo(44)
        }
        
        resultLbl.snp.makeConstraints { make in
            make.top.equalTo(option3Lbl.snp.bottom).offset(24)
            make.left.equalTo(resultIconView.snp.right).offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        answerLbl.snp.makeConstraints { make in
            make.top.equalTo(resultLbl.snp.bottom).offset(24)
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
            guard let value = values.first else {
                self?.check1Btn.setImage(radioUncheckIcon, for: .normal)
                self?.check2Btn.setImage(radioUncheckIcon, for: .normal)
                self?.check3Btn.setImage(radioUncheckIcon, for: .normal)
                return
            }
            self?.check1Btn.setImage(value == 0 ? radioCheckIcon : radioUncheckIcon, for: .normal)
            self?.check2Btn.setImage(value == 1 ? radioCheckIcon : radioUncheckIcon, for: .normal)
            self?.check3Btn.setImage(value == 2 ? radioCheckIcon : radioUncheckIcon, for: .normal)
            
            self?.resultIconView.isHidden = false
            self?.resultLbl.isHidden = false
            
            if "\(value)" == data.answer {
                self?.answerLbl.isHidden = true
                // 回答正确.
                self?.resultIconView.image = correctIcon
                self?.resultLbl.text = "正解！"
                self?.resultLbl.textColor = UIColor.green
            } else {
                self?.answerLbl.isHidden = false
                // 回答错误.
                self?.resultIconView.image = wrongIcon
                self?.resultLbl.text = "不正解！"
                self?.resultLbl.textColor = UIColor.red
            }
        }.disposed(by: disposeBag)
        
        // tap event.
        self.check1Btn.rx.tap.bind {
            data.selection.value = [0]
        }.disposed(by: disposeBag)
        
        self.check2Btn.rx.tap.bind {
            data.selection.value = [1]
        }.disposed(by: disposeBag)
        
        self.check3Btn.rx.tap.bind {
            data.selection.value = [2]
        }.disposed(by: disposeBag)
        
        // text bind.
        let recognizer1 = UITapGestureRecognizer()
        recognizer1.rx.event.bind { sender in
            data.selection.value = [0]
        }.disposed(by: disposeBag)
        option1Lbl.isUserInteractionEnabled = true
        option1Lbl.addGestureRecognizer(recognizer1)
        
        let recognizer2 = UITapGestureRecognizer()
        recognizer2.rx.event.bind { sender in
            data.selection.value = [1]
        }.disposed(by: disposeBag)
        option2Lbl.isUserInteractionEnabled = true
        option2Lbl.addGestureRecognizer(recognizer2)
        
        let recognizer3 = UITapGestureRecognizer()
        recognizer3.rx.event.bind { sender in
            data.selection.value = [2]
        }.disposed(by: disposeBag)
        option3Lbl.isUserInteractionEnabled = true
        option3Lbl.addGestureRecognizer(recognizer3)
        
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
