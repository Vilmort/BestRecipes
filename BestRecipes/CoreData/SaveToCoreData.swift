//
//  SaveToCoreData.swift
//  BestRecipes
//
//  Created by Vanopr on 02.09.2023.
//

import CoreData
import UIKit

struct SaveToCoreData {
  static  func saveProfileImageToCoreData(_ image:UIImage) {
    var context: NSManagedObjectContext!
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    context = appDelegate.persistentContainer.viewContext
    if let imageData = image.pngData() {
      let image = PicturePofileModel(context: context)
      image.imageProfile = imageData
      do {
        try context.save()
        print("Изображение успешно сохранено")
      } catch {
        print("Ошибка при сохранении: \(error)")
      }
    }
  }

  static func saveRecipeInfoToCoreData(_ image:UIImage, _ title:String, _ serves:String, _ cookTime:String)  {
    var context: NSManagedObjectContext!
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    context = appDelegate.persistentContainer.viewContext
    let myRecipe = MyRecipe(context: context)
    myRecipe.recipeName = title
    myRecipe.serves = serves
    myRecipe.cookTime = cookTime
    if let imageData = image.pngData() {
      myRecipe.recipeImage = imageData
      do {
        try context.save()
        print(" рецепт успешно сохранен")
      } catch {
        print("Ошибка при сохранении рецепта : \(error)")
      }
    }
  }

  static func saveArrayOfArraysToCoreData(_ arrayOfArrays: [[RowDataCell]]) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Ingridients", in: context)
    for array in arrayOfArrays {
      let coreDataObject = NSManagedObject(entity: entity!, insertInto: context)
      do {
        let jsonData = try JSONEncoder().encode(array)
        coreDataObject.setValue(jsonData, forKey: "ingridients")
        try context.save()
      } catch {
        print("Ошибка при сохранении: \(error)")
      }
    }
  }

  static func saveRecentArrayToCoreData(_ id: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Recent", in: context)
    let coreDataObject = NSManagedObject(entity: entity!, insertInto: context)
    do {
      coreDataObject.setValue(id, forKey: "recent")
      try context.save()
    } catch {
      print("Ошибка при сохранении: \(error)")
    }
  }
}
