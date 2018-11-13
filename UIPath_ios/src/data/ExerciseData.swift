//
//  ExersizeData.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

struct ExerciseData {
    let id: Int
    let chapterId: Int
    let question : String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let answer: String
    let type: Int
    
    var selection = Variable([Int]())
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.chapterId = json["chapterId"].intValue
        self.question = json["question"].stringValue
        self.option1 = json["option1"].stringValue
        self.option2 = json["option2"].stringValue
        self.option3 = json["option3"].stringValue
        self.option4 = json["option4"].stringValue
        self.answer = json["answer"].stringValue
        self.type = json["type"].intValue
    }
}
