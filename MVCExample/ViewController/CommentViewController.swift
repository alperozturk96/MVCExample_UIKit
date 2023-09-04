//
//  CommentViewController.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import UIKit

final class CommentViewController: UIViewController {
    
    // MARK: - Variables
    private let commentTableView: UITableView = UITableView()
    private var comments: [Comment] = .init()
    
    // MARK: - Dependencies
    private let repository: CommentFetcher
    
    init(repository: CommentFetcher = CommentRepository()) {
        self.repository = repository
        super.init(nibName: "CommentView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupCommentTableView()
        fetchComments()
    }
}

// MARK: - RemoteCalls
extension CommentViewController {
    func fetchComments() {
        Task {
            do {
                let result = try await repository.fetchComments()
                await MainActor.run {
                    self.comments = result
                    commentTableView.reloadData()
                }
            } catch {
                print("Error caught at fetchComments: \(error.localizedDescription)")
            }
          
        }
    }
}

// MARK: - SetupTableView
extension CommentViewController {
    private func setupCommentTableView() {
        commentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(commentTableView)
        
        commentTableView.translatesAutoresizingMaskIntoConstraints = false
        commentTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        commentTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        commentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        commentTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
        navigationController?.pushViewController(CommentDetailViewController(comment: comment), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        var content = cell.defaultContentConfiguration()
     
        content.text = comments[indexPath.row].email
        content.secondaryText = comments[indexPath.row].body
        cell.contentConfiguration = content
        
        return cell
    }
}
