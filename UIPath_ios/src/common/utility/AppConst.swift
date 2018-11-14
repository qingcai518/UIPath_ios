//
//  AppConst.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import UIKit

// screen width.
let screenWidth = UIScreen.main.bounds.width
// screen height.
let screenHeight = UIScreen.main.bounds.height

// status bar height.
let statusbarHeight = UIApplication.shared.statusBarFrame.height

// tabbar height.
func tabHeight (_ tabbarController: UITabBarController?) -> CGFloat {
    guard let tabbarController = tabbarController else {return 0}
    return tabbarController.tabBar.frame.height
}

func naviHeight(_ naviController: UINavigationController?) -> CGFloat {
    guard let naviController = naviController else {return 0}
    return naviController.navigationBar.frame.height
}

var safeArea : UIEdgeInsets = {
    let defaultInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    if #available(iOS 11.0, *) {
        if let insets = UIApplication.shared.keyWindow?.safeAreaInsets {
            return insets
        }
    }
    
    return defaultInsets
}()

let testCount = 30   // 考试题个数.
