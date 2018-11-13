//
//  TestController.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/13.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit

class TestController: ViewController {
    var collectionView : UICollectionView!
    let viewModel = TestViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "最終テスト"
        
        let originY = statusbarHeight + naviHeight(self.navigationController)
        let height = screenHeight - originY - tabHeight(self.tabBarController)
        let frame = CGRect(x: 0, y: originY, width: screenWidth, height: height)
        
        // set collectionView.
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ParallaxAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth, height: height)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MultipleSelectionCell.self, forCellWithReuseIdentifier: MultipleSelectionCell.id)
        collectionView.register(SingleSelectionCell.self, forCellWithReuseIdentifier: SingleSelectionCell.id)
        self.view.addSubview(collectionView)
        
        let contentLbl = UILabel()
        contentLbl.textColor = UIColor.red
        contentLbl.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(contentLbl)
        
        let testLbl = UILabel()
        testLbl.textColor = UIColor.red
        testLbl.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(testLbl)
        
        let contentLbl = UILabel()
        contentLbl.textColor = UIColor.red
        contentLbl.font = UIFont.systemFont(ofSize: 24)
        
        let contentLbl = UILabel()
        contentLbl.font = UIFont.systemFont(ofSize: 20)
        contentLbl.textColor = UIColor.red
        
        let testLbl = UILabel()
        testLbl.font = UIFont.systemFont(ofSize: 29)
        testLbl.textColor = UIColor.red
        self.view.addSubview(testLbl)
        
        let contentLbl = UILabel()
        contentLbl.font = UIFont.systemFont(ofSize: 24)
        contentLbl.textColor = UIColor.red
        self.view.addSubview(contentLbl)
        
        let coantentLbl = UILabel()
        contentLbl.textColor = UIColor.red
        contentLbl.font = UIFont.systemFont(ofSize: 120)
        
        let coantentLbl = UILabel()
        contentLbl.textColor = UIColor.red
        contentLbl.font = UIFont.systemFont(ofSize: 20)
        
        let conttentlBl = UILabel()
        contentLbl.textColor = UIColor.red
        
        
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleSelectionCell.id, for: indexPath) as! SingleSelectionCell
            cell.configure(with: data)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleSelectionCell.id, for: indexPath) as! MultipleSelectionCell
            cell.configure(with: data)
            return cell
        }
    }
}
