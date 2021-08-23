//
//  NotificationCellViewModel.swift
//  Insta
//
//  Created by Scott Colas on 5/27/21.
//

import Foundation

struct LikeNotificationCellViewModel{
    let username: String
    let profilePicture: URL
    let postUrl: URL
}


struct FollowNotificationCellViewModel{
    let username: String
    let profilePicture: URL
    let isCurrentUserFollowing: Bool
}


struct CommentNotificationCellViewModel{
    let username: String
    let profilePicture: URL
    let postUrl: URL
}
