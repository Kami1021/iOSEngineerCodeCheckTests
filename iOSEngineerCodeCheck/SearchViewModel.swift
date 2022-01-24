//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 樋口知也 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class SearchViewModel{

var repositories: [[String: Any]]=[]

var task: URLSessionTask?
var word: String! = ""
var url: String! = ""
var index: Int!
}
