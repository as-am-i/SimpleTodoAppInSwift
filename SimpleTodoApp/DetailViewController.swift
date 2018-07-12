//
//  DetailViewController.swift
//  SimpleTodoApp
//
//  Created by 谷井朝美 on 2018-07-11.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoDescriptionLabel: UILabel!
    @IBOutlet weak var todoPriorityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var todo: Todo? {
        didSet {
            refreshUI()
        }
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        todoTitleLabel.text = todo?.title
        todoDescriptionLabel.text = todo?.todoDescription
        todoPriorityLabel.text = "\(todo?.priority ?? 0)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
