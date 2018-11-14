//
//  TestViewModel.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/13.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class TestViewModel {
    var tests = [ExerciseData]()
    
    func getTest(onSuccess: @escaping () -> Void, onFail: @escaping (String) -> Void) {
        guard let api = URLComponents(string: testAPI) else {
            return onFail("Invalid API.")
        }
        
        Alamofire.request(api, method: .get).response { response in
            if let error = response.error {
                return onFail(error.localizedDescription)
            }
            
            guard let data = response.data else {
                return onFail("Fail to get data.")
            }
            
            let json = JSON(data)
            self.tests = json.arrayValue.map{ExerciseData($0)}
            return onSuccess()
        }
    }
}
