//
//  TesttopControlleer.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

class TesttopController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        
        let titleLbl = UILabel()
        titleLbl.text = "テストは、全ての問題集から30個をランダムで出している。実際のUiPathの最終テストと異なる可能性がある。"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        titleLbl.numberOfLines = 0
        self.view.addSubview(titleLbl)
        
        let confirmBtn = UIButton()
        confirmBtn.setBackgroundImage(UIImage.from(color: UIColor.orange), for: .normal)
        confirmBtn.setBackgroundImage(UIImage.from(color: UIColor.lightGray), for: .highlighted)
        confirmBtn.layer.cornerRadius = 12
        confirmBtn.clipsToBounds = true
        confirmBtn.setTitle("テスト開始", for: .normal)
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(confirmBtn)
        
        confirmBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.bottom.equalTo(confirmBtn.snp.top).offset(-44)
            make.left.right.equalToSuperview().inset(24)
        }
        
        confirmBtn.rx.tap.bind { [weak self] in
            let test = TestController()
            let next = UINavigationController(rootViewController: test)
            self?.present(next, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
}
