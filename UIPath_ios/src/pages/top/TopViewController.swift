//
//  ViewController.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit
import SVProgressHUD

class TopViewController: ViewController {
    lazy var tableView = UITableView()
    lazy var logoView = UIImageView()
    let viewModel = TopViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        getData()
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "UiPath 問題集"
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(ChapterCell.self, forCellReuseIdentifier: ChapterCell.id)
        tableView.rowHeight = 64
        self.view.addSubview(tableView)
        
        logoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 120)
        logoView.contentMode = .scaleAspectFit
        logoView.clipsToBounds = true
        logoView.image = UIImage(named: "uipath_logo")!
        self.view.addSubview(logoView)
        tableView.tableHeaderView = logoView
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func getData() {
        SVProgressHUD.show()
        viewModel.getChapters(onSuccess: {[weak self] in
            SVProgressHUD.dismiss()
            self?.tableView.reloadData()
        }) { msg in
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: msg)
        }
    }
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let next = ExerciseController()
            let data = viewModel.chapters[indexPath.row]
            next.chapter = data
            self.navigationController?.pushViewController(next, animated: true)
        } else {
            let next = TestController()
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titles[section]
    }
}

extension TopViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.chapters.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChapterCell.id, for: indexPath) as! ChapterCell
        if indexPath.section == 0 {
            if viewModel.chapters.count > indexPath.row {
                let data = viewModel.chapters[indexPath.row]
                cell.configure(with: data)
            }
        } else {
            cell.configure(with: "最終テスト")
        }
        return cell
    }
}
