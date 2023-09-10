# Best Recipes
<img src="https://github.com/Loveink/BestRecipes/blob/develop/assets/readmegif.gif" width="900">

---

<p align="left"> 
<a href="https://swift.org">
<img src="https://img.shields.io/badge/Swift-5.7-orange" alt="Swift Version 5.7" /></a>
<a href="https://developer.apple.com/ios/">
<img src="https://img.shields.io/badge/iOS-15.0%2B-success" alt="iOS Version 15.0"/></a>
<img src="https://img.shields.io/badge/MVC-ff69b4" alt="MVC" /></a>
<img src="https://img.shields.io/badge/No storyboard-purple" alt="MVC" /></a>
</p>

### В разработке участвовали:
<p align="left"> 
<a href="https://github.com/Loveink">
<img src="https://img.shields.io/badge/Loveink-pink"/></a>
<a href="https://github.com/Vanopr">
<img src="https://img.shields.io/badge/Vanopr-red"/></a>
<a href="https://github.com/sattarov-t">
<img src="https://img.shields.io/badge/sattarov_t-green"/></a>
<a href="https://github.com/vtagilov">
<img src="https://img.shields.io/badge/vtagilov-blue"/></a>
<a href="https://github.com/AnastasiaRybakova26">
<img src="https://img.shields.io/badge/AnastasiaRybakova26-purple"/></a>
</p>
Приложение сделано для https://t.me/swiftmarathon

---

<img width="1670" src="https://github.com/Loveink/BestRecipes/blob/develop/assets/readmeimage.png">

---
# Описание:

**Онбоардинг**

* Показывается только при первом заходе в приложение

**Главный экран**

* Поиск рецептов в search bar
* Коллекция с популярными рецептами
* Коллекция с рецептами по категорями.
* Коллекция с различными кухнями
* Коллекция с недавно просмотренными рецептами

**Экран избранных рецептов**

* Показывается коллекция с избранными рецептами. Можно добавить в избранное на ячейке с рецептом
* Сохранение в User Defaults

**Экран рецепта**

* Показывается изображение блюда
* Количество лайков (из API)
* Подробная иструкция по шагам
* Ингредиенты (изображение, название, количество в граммах)
* Рядом с каждым ингредиентом есть иконка "корзина", при нажатии на кнопку "Add to shopping list" ингредиенты попадают на экран с шопинг листом

**Экран "Добавить свой рецепт"**

* На экране открывается форма для добавления собственного рецепта
* Можно добавить собственно изображение из галереи или использовать дефолтное
* Ингредиенты добавляются по кнопке +
* Обязательные поля выделены красным, пока не заполнены

**Экран "Shopping List"**

* На экране открывается список с ингредиентами, добавленными в шопинг лист из детальных экранов рецепта
* Можно удалить ингредиет свайпом влево либо удалить все кнопкой "Clear shopping list"

**Экран профиля**

* На экране показывается изображение аватара, можно выбрать из готовых вариантов или загрузить свой
* Коллекция со своими собственными рецептами, добавленными через экран "Добавить свой рецепт"
