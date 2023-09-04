//
//  CommentDetailViewController.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import UIKit

final class CommentDetailViewController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var body: UILabel!
    
    let comment: Comment
   
    init(comment: Comment) {
        self.comment = comment
        super.init(nibName: "CommentDetailView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 10
        
        name.text = comment.name
        email.text = comment.email
        body.text = comment.body
    }
}
