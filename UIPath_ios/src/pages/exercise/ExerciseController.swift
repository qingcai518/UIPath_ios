//
//  ExerciseController.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import UIKit
import SVProgressHUD

class ExerciseController: ViewController {
    var collectionView : UICollectionView!
    let viewModel = ExerciseViewModel()
    
    // params.
    var chapter: ChapterData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        getData()
    }
    
    private func setSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = chapter?.name
        
        let originY = statusbarHeight + naviHeight(self.navigationController)
        let height = screenHeight - originY - tabHeight(self.tabBarController)
        let frame = CGRect(x: 0, y: originY, width: screenWidth, height: height)
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = CubeAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth, height: height)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print("multiple id ==== \(MultipleSelectionCell.id)")
        print("single id === \(SingleSelectionCell.id)")
        
        collectionView.register(SingleSelectionCell.self, forCellWithReuseIdentifier: SingleSelectionCell.id)
        collectionView.register(MultipleSelectionCell.self, forCellWithReuseIdentifier: MultipleSelectionCell.id)
        self.view.addSubview(collectionView)
    }
    
    private func getData() {
        SVProgressHUD.show()
        viewModel.getExercises(chapterId: chapter?.id, onSuccess: { [weak self] in
            SVProgressHUD.dismiss()
            self?.collectionView.reloadData()
        }) { msg in
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: msg)
        }
    }
}

extension ExerciseController: UICollectionViewDelegate {
    
}

extension ExerciseController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.exercises[indexPath.row]
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
