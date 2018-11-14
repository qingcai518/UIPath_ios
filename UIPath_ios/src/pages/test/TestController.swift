//
//  TestController.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/13.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit
import SVProgressHUD

class TestController: ViewController {
    var collectionView : UICollectionView!
    let viewModel = TestViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    private func getData() {
        SVProgressHUD.show()
        viewModel.getTest(onSuccess: { [weak self] in
            SVProgressHUD.dismiss()
            self?.collectionView.reloadData()
        }) { msg in
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: msg)
        }
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "最終テスト"
        
        // 閉じるボタン.
        let closeBtn = UIButton()
        closeBtn.setTitle("閉じる", for: .normal)
        closeBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let closeItem = UIBarButtonItem(customView: closeBtn)
        self.navigationItem.leftBarButtonItem = closeItem
        
        // 评分按钮.
        let scoreBtn = UIButton()
        scoreBtn.setTitleColor(UIColor.orange, for: .normal)
        scoreBtn.setTitle("採点", for: .normal)
        scoreBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        scoreBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let scoreItem = UIBarButtonItem(customView: scoreBtn)
        self.navigationItem.rightBarButtonItem = scoreItem
        
        let originY = statusbarHeight + naviHeight(self.navigationController)
        let height = screenHeight - originY - tabHeight(self.tabBarController)
        let frame = CGRect(x: 0, y: originY, width: screenWidth, height: height)
        
        // set collectionView.
        let layout = AnimatedCollectionViewLayout()
        layout.animator = RotateInOutAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth, height: height)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MultipleCell.self, forCellWithReuseIdentifier: MultipleCell.id)
        collectionView.register(SingleCell.self, forCellWithReuseIdentifier: SingleCell.id)
        self.view.addSubview(collectionView)
        
        closeBtn.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        scoreBtn.rx.tap.bind { [weak self] in
            let alertController = UIAlertController(title: nil, message: "採点しますか？", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "確認", style: .destructive, handler: { [weak self] action in
                guard let `self` = self else {return}
                let next = ResultController()
                next.tests = self.viewModel.tests
                self.navigationController?.pushViewController(next, animated: true)
            })
            let action2 = UIAlertAction(title: "キャンセル　", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            self?.present(alertController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
}

extension TestController : UICollectionViewDelegate {
    
}

extension TestController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.tests[indexPath.row]
        
        if data.type == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleCell.id, for: indexPath) as! SingleCell
            cell.configure(with: data)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleCell.id, for: indexPath) as! MultipleCell
            cell.configure(with: data)
            return cell
        }
    }
}
