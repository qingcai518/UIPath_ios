//
//  ResultController.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

class ResultController: ViewController {
    lazy var tableView = UITableView()
    
    // param.
    var tests = [ExerciseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "採点結果"
        
        // add close button.
        let closeBtn = UIButton()
        closeBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.setTitle("終了", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let itemBtn = UIBarButtonItem(customView: closeBtn)
        self.navigationItem.rightBarButtonItem = itemBtn
        
        closeBtn.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.id)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ResultController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.id, for: indexPath) as! ResultCell
        if indexPath.row < tests.count {
            let data = tests[indexPath.row]
            cell.configure(with: data)
        }
        return cell
    }
}
