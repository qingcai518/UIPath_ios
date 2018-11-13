//
//  ExerciseViewModel.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExerciseViewModel {
    var exercises = [ExerciseData]()
    
    func getExercises(chapterId: Int?, onSuccess: @escaping () -> Void, onFail: @escaping (String) -> Void) {
        guard let chapterId = chapterId else {return onFail("Invalid chapter.")}
        guard var api = URLComponents(string: exerciseAPI) else {return onFail("Invalid api.")}
        api.queryItems = [
            URLQueryItem(name: "chapter_id", value: "\(chapterId)")
        ]
        
        Alamofire.request(api, method: .get).responseJSON { response in
            if let error = response.error {
                return onFail(error.localizedDescription)
            }
            
            guard let data = response.data else {
                return onFail("have no response data.")
            }
            
            let json = JSON(data)
            self.exercises = json.arrayValue.map{ExerciseData($0)}
            return onSuccess()
        }
    }
}
