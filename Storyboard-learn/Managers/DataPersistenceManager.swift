//
//  DataPersistenceManager.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import Foundation
import UIKit
import CoreData



class DataPersistenceManager{
    
    enum DatabaseError:Error{
        case failedToSaveData
        case failedToFetch
        case failedToDeleteData
    }
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model:Title, completion: @escaping (Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchTitle(completion: @escaping (Result<[TitleItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        var request = NSFetchRequest<TitleItem>()
        request = TitleItem.fetchRequest()
        do{
           let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(DatabaseError.failedToFetch))
        }
    }
    
    
    func deleteTitle(model:TitleItem,completion: @escaping (Result<Void,Error>) -> Void ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
