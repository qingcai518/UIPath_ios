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
    let questionLbl = UILabel()
    let check1Btn = UIButton()
    let check2Btn = UIButton()
    let check3Btn = UIButton()
    let option1Lbl = UILabel()
    let option2Lbl = UILabel()
    let option3Lbl = UILabel()
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLbl.text = nil
        option1Lbl.text = nil
        option2Lbl.text = nil
        option3Lbl.text = nil
        
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
    }
}
