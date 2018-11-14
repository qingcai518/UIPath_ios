//
//  ResultViewModel.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import SVProgressHUD

class ResultViewModel {
    func getScore(tests: [ExerciseData]) {
        var count = 0
        for test in tests {
            let selection = test.selection.value.sorted(by: < ).map{"\($0)"}.joined(separator: ",")
            let answer = test.answer
            if selection == answer {
                count += 1
            }
        }
        
        // get result.
        let ratio = Double(count) / Double(tests.count)
        let result = ratio >= 0.7 ? "合格🥗" : "不合格👎"
        print("result = \(Double(count) / Double(tests.count))")
        SVProgressHUD.showSuccess(withStatus: "結果：\n\(tests.count)問中、正解\(count)個\n\(result)")
    }
}
