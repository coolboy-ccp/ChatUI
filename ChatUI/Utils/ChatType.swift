//
//  ChatType.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

enum MessageContentType {
    case text
    case image
    case voice
    case system
    case file
    case time
}

enum MessageFromType {
    case system
    case personal
    case group
    case server
    case subscribe
}

