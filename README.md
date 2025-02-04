# CountriesTest

Приложение для отображения списка стран, их детализированной информации и добавления в избранное.

## Установка

1. Клонируйте репозиторий на свой компьютер:
   
   git clone https://github.com/lordcordis/CountriesTest.git

2. Откройте проект в Xcode:

    open CountriesTest.xcodeproj

## Сборка и запуск

Откройте проект в Xcode.
Выберите нужный симулятор или подключите устройство.
Нажмите на кнопку Run в Xcode или используйте сочетание клавиш Cmd + R.

## Использованные технологии и решения

- **SwiftUI**: Используется для создания пользовательского интерфейса. View находятся в контейнерах `UIHostingController`, что позволяет интегрировать навигацию через Coordinator на базе UIKit и легко расширять проект.
  
- **MVVM (Model-View-ViewModel)**: Архитектурный паттерн для разделения логики представления и бизнес-логики, улучшая тестируемость и поддерживаемость кода.

- **CoreData**: Используется для хранения информации о странах в локальной базе данных, что позволяет сохранять и управлять избранными странами между сессиями приложения.

- **MapKit**: Используется для отображения карты и географического положения страны.

- **PDF генерация**: Реализована функция генерации PDF-файлов с информацией о странах, которую можно экспортировать.

- **Localization (Локализация)**: Реализована поддержка русского и английского языка с использованием `.xcstrings`.

- **async/await**: Используется для упрощения работы с асинхронными операциями совместно с escaping closures.

- **.xcconfig**: Все URL-адреса API хранятся в конфигурационных файлах `.xcconfig`, что позволяет централизованно управлять различными средами (например, для разработки, тестирования и продакшн), улучшая безопасность и удобство в процессе разработки.

- **Assets**: Цветовая палитра приложения хранится в **Assets**, что позволяет централизованно управлять цветами и упрощает поддержку различных тем и стилей в интерфейсе.

- **Dependency Injection**: В проекте в большинстве используется принцип **dependency injection** для внедрения зависимостей в различные компоненты приложения.
