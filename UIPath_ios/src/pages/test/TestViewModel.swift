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
    
    func getTest(onSucces: @escaping () -> Void, onFail: @escaping (String) -> Void) {
        guard let api = URLComponents(string: testAPI) else {return onFail("Invalid api.")}
        Alamofire.request(api, method: .get).responseJSON { response in
            if let error = response.error {
                return onFail(error.localizedDescription)
            }
            
            guard let data = response.data else {
                return onFail("have no response data.")
            }
            
            let json = JSON(data)
            self.tests = json.arrayValue.map{ExerciseData($0)}
            return onSucces()
        }
    }
}
