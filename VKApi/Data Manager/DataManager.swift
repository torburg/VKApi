//
//  DataManager.swift
//  VKApi
//
//  Created by Maksim Torburg on 07.08.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()
    let networkManager = NetworkManager()
    
    func getData() {
        networkManager.sendRequest { (result) in
            switch result {
            case .success(let result):
                for item in result.response.items {
                    self.createAndSavePost(from: item)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createAndSavePost(from item: Item) {        
        let id = Int64(item.id)
        var avatarURL: String?
        if let attachmentType = item.attachments?.first?.type {
            switch attachmentType {
            case "video":
                avatarURL = item.attachments?.first?.video?.photoSmall
            case "link":
                avatarURL = item.attachments?.first?.link?.imageSrc
            case "photo":
                avatarURL = item.attachments?.first?.photo?.photoSmall
            case "graffiti":
                avatarURL = item.attachments?.first?.graffiti?.photoSmall
            default:
                avatarURL = nil
            }
        }
        let title = item.text
        let content = item.text
        let date = Int64(item.date)
        let likesAmount = Int64(item.likes.count)
        let commentAmount = Int64(item.comments.count)
        let repostsAmount = Int64(item.reposts.count)
        
        let post = Post(context: self.persistentContainer.viewContext)
        post.avatar = avatarURL
        post.commentAmount = commentAmount
        post.content = content
        let timeInterval = TimeInterval(integerLiteral: date)
        post.date = Date(timeIntervalSince1970: timeInterval)
        post.id = id
        post.likesAmount = likesAmount
        post.repostAmount = repostsAmount
        post.title = title
        
        saveContext()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VKApi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
