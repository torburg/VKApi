//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Maksim Torburg on 07.08.2020.
//
//

import Foundation
import CoreData
import UIKit

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var avatar: UIImage?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var content: String?
    @NSManaged public var likesAmount: Int64
    @NSManaged public var commentAmount: Int64
    @NSManaged public var repostAmount: Int64
    @NSManaged public var photo: UIImage?

}
