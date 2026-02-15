//
//  WeekdaySetValueTransformer.swift
//  Tracker
//
//  Created by Denis Bokov on 15.02.2026.
//

import Foundation

// Обязательно помечаем @objc, иначе Core Data не увидит трансформер
@objc
final class WeekdaySetValueTransformer: ValueTransformer {

    // Сообщаем системе, какой тип данных мы храним в базе
    // Core Data будет хранить Data (NSData)
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }

    // Обратная трансформация Data в Set<Weekday>
    override class func allowsReverseTransformation() -> Bool {
        true
    }


    // Преобразуем Set<Weekday> в Data
    override func transformedValue(_ value: Any?) -> Any? {
        // Проверяем, что пришло то, что мы ожидаем
        guard let weekdays = value as? Set<Weekday> else { return nil }
        // Кодируем Set как Array, потому что JSONEncoder не умеет кодировать Set напрямую
        let array = Array(weekdays)
        // Кодируем в JSON Data
        return try? JSONEncoder().encode(array)
    }

    // Преобразуем Data в Set<Weekday>
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        // Проверяем тип
        guard let data = value as? Data else { return nil }
        // Декодируем массив из JSON
        guard let array = try? JSONDecoder().decode([Weekday].self, from: data) else { return nil }
        // Преобразуем обратно в Set
        return Set(array)
    }

    // Метод для регистрации трансформера при старте приложения
    static func register() {
        ValueTransformer.setValueTransformer(
            WeekdaySetValueTransformer(),
            forName: NSValueTransformerName(
                rawValue: String(describing: WeekdaySetValueTransformer.self)
            )
        )
    }
}
