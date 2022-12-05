//
//  CategoryModuleEntity.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Foundation
import RealmSwift

public class CategoryModuleEntity: Object {

    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""

    public override static func primaryKey() -> String? {
        return "id"
    }
}
