//
//  BloodTypeEntity.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/10/01.
//

import AppIntents

struct BloodTypeEntity: AppEntity {
    var id: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(stringLiteral: id)
    }
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Label.BloodType"
    static var defaultQuery = BloodTypeQuery()
}

struct BloodTypeQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [BloodTypeEntity] {
        return identifiers.map( { BloodTypeEntity(id: $0) })
    }
    
    func suggestedEntities() -> [BloodTypeEntity] {
        return BloodType.allCases.map({ BloodTypeEntity(id: $0.rawValue) })
    }
}
