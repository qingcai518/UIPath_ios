//
//  TopViewModel.swift
//  UIPath_ios
//
//  Created by liqc on 2018/11/12.
//  Copyright © 2018年 liqc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TopViewModel {
    var chapters = [ChapterData]()
    let titles = ["問題集", "テスト"]
    
    func getChapters(onSuccess: @escaping () -> Void, onFail: @escaping (String) -> Void) {
        
        print(chapterAPI)
        
        guard let api = URLComponents(string: chapterAPI) else {
            return onFail("Invalid api.")
        }
        
        Alamofire.request(api, method: .get).responseJSON { response in
            if let error = response.error {
                return onFail(error.localizedDescription)
            }
            
            guard let data = response.data else {
                return onFail("Have no response data.")
            }
            
            let json = JSON(data)
            self.chapters = json["data"].arrayValue.map{ChapterData($0)}
            return onSuccess()
        }
    }
}
