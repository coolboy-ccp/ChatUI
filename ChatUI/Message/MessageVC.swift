//
//  MessageVC.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {
    @IBOutlet fileprivate weak var listTableView: UITableView!
    
    private let addView = AddMessageView(64)
    private let data = [MessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        view.backgroundColor = .viewBackgroundColor
        self.navigationItem.right(ChatImg.Barbuttonicon_add.image) { [unowned self] in
            self.addView.isShow = !self.addView.isShow
        }
        listTableView.registerCellNib(MessageCell.self)
        listTableView.estimatedRowHeight = 65
        listTableView.tableFooterView = UIView()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if addView.isShow {
            addView.isShow = false
        }
    }
    
    private func fetchData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MessageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chat = ChatVC.fromXib(ChatVC.self)
        self.navigationController?.pushViewController(chat, animated: true)
    }
}

extension MessageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(MessageCell.self)
        cell.setContent(data[indexPath.row])
        return cell
    }
}
