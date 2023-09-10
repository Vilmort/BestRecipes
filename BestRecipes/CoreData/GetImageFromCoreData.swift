

//
//  GetImageFromCoreData.swift
//  BestRecipes
//
//  Created by Vanopr on 30.08.2023.
//

import Foundation
import UIKit
import CoreData

var imageProfileViewSaved = GetFromCoreData.getProfileImageFromCoreData()
var context: NSManagedObjectContext!

struct GetFromCoreData {

  static func getProfileImageFromCoreData() -> UIImage {
    let imageProfileModels: [PicturePofileModel]
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return UIImage(named: "ProfilePicture2")!
    }
    context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<PicturePofileModel> = PicturePofileModel.fetchRequest()
    do {
      imageProfileModels = try context.fetch(fetchRequest)
      let imageProfileModel = imageProfileModels.last
      if let image = imageProfileModel?.imageProfile  {
        if let uiImage = UIImage(data: image) {
          saveJustLastImage(imageProfileModels)
          print("Количество сохраненных изображений: \(imageProfileModels.count)")
          return uiImage
        }
      }
    } catch {
      print("Ошибка при выполнении запроса: \(error)")
    }
    return UIImage(named: "ProfilePicture2")!
  }

  static func saveJustLastImage(_ imageProfileModels: [PicturePofileModel]) {
    do {
      if imageProfileModels.count > 1 {
        for i in 0..<imageProfileModels.count  {
          context.delete(imageProfileModels[i])
        }
        try context.save()
      }
    } catch {
      print("Ошибка при извлечении данных: \(error)")
    }
  }

  static func getRecipeMyRecipeModelsFromCoreData() -> [MyRecipe] {
    var myRecipeModels: [MyRecipe] = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return myRecipeModels
    }
    context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
    do {
      myRecipeModels = try context.fetch(fetchRequest)
    } catch {
      print("Ошибка при выполнении запроса: \(error)")
    }
    return myRecipeModels
  }

  static func fetchArrayOfArraysFromCoreData() -> [[RowDataCell]] {
    var arrayOfArrays: [[RowDataCell]] = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return arrayOfArrays
    }
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingridients")
    do {
      let coreDataObjects = try context.fetch(fetchRequest)

      for case let coreDataObject as NSManagedObject in coreDataObjects {
        if let jsonData = coreDataObject.value(forKey: "ingridients") as? Data,
           let rowDataArray = try? JSONDecoder().decode([RowDataCell].self, from: jsonData) {
          arrayOfArrays.append(rowDataArray)
        }
      }
    } catch {
      print("Ошибка при извлечении данных из CoreData: \(error)")
    }
    return arrayOfArrays
  }


  static func getRecentIdFromCoreData() -> [Int] {
    var recentIds: [Int] = []

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return recentIds
    }

    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Recent> = Recent.fetchRequest()

    do {
      let recentObjects = try context.fetch(fetchRequest)
      recentIds = recentObjects.compactMap { Int($0.recent) }

      if recentIds.count > 10 {
        recentIds = Array(recentIds.suffix(10))
      }

      var uniqueArray = [Int]()
      for element in recentIds {
        if !uniqueArray.contains(element) {
          uniqueArray.append(element)
        } else {
          uniqueArray.removeAll { $0 == element }
          uniqueArray.append(element)
        }
      }
      recentIds = uniqueArray.reversed()
    } catch {
      print("Ошибка при выполнении запроса: \(error)")
    }
    print("--")
    return recentIds
  }
}
