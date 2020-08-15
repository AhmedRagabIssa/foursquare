//
//  ViewController.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient().getData(request: SimpleGetRequest(url: "https://jsonplaceholder.typicode.com/todos/1"), mapResponseOnType: Todo.self, successHandler: { (response) in
            print("sucess")
        }) { (error) in
            print("failure")
        }
    }


}

struct Todo: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
