//
//  Post+CoreDataProperties.swift
//  VKApi
//
//  Created by Maksim Torburg on 11.08.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var avatar: UIImage?
    @NSManaged public var commentAmount: Int64
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var likesAmount: Int64
    @NSManaged public var photo: UIImage?
    @NSManaged public var repostAmount: Int64
    @NSManaged public var title: String?

}
