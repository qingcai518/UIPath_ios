//
//  ResultViewModel.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/14.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift

class ResultViewModel {
    var result = Variable<String>("-")
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
        let content = ratio >= 0.7 ? "合格🥗" : "不合格👎"
        self.result.value = content + " (\(count)正解 / \(tests.count)問中)"
    }
}
