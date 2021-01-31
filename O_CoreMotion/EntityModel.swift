//
//  EntityModel.swift
//  O_CoreMotion
//
//  Created by olivier robin on 30/01/2021.
//

import Foundation


// note :
// for this test, http://dev.tapptic.com/test/json.php is used and return a model which is not possible to change

class NumberImageEntity: Codable  {
    
    var name: String = ""       // name to be displayed
    var image: String = ""      // image url
    
    init(name: String, imageURL: String) {
        self.name = name
        self.image = imageURL
    }
}

extension NumberImageEntity: Equatable {
    
  static func == (lhs: NumberImageEntity, rhs: NumberImageEntity) -> Bool {
    lhs.name == rhs.name  && lhs.image == rhs.image
  }
}

extension NumberImageEntity: Identifiable { }
