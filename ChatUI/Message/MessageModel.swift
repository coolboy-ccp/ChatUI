//
//  MessageModel.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class MessageModel {
    var middleImageURL : String?
    var unreadNumber : Int?
    var nickname : String?
    var fromType : MessageFromType = MessageFromType.personal
    var contentType : MessageContentType = MessageContentType.text
    var chatId : String?  //每个人，群，公众帐号都有一个 uid，统一叫 chatId
    var latest : String? //当且仅当消息类型为 Text 的时候，才有数据，其他类型需要本地造
    var dateString: String?
}

class AudioModel {
    
}

class ImageModel {
    
}
