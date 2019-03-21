//
//  NetworkRequest.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 17/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequest {
   func getRequest(_ url: URL, completion: @escaping ([Match]?, Error?) -> Void)
}


