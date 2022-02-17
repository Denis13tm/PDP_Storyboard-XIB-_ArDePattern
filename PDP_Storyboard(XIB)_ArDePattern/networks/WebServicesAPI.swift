//
//  WebServicesAPI.swift
//  PDP_Storyboard(XIB)_ArDePattern
//
//  Created by Otabek Tuychiev
//

import Foundation
import Alamofire


public class UserAPI: NSObject, ObservableObject {
    
    @Published var isLoading = false
    let url: String =  "https://api.github.com/users/Denis13tm"
    
    func getSingleUser(completion: @escaping(User) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            self.isLoading = true
            switch response.result {
            case .success(_):
                do{
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(User.self, from: response.data!)
                    completion(data)
                } catch(let error) {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
