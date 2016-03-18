//
//  Kitten.swift
//  KittenKit
//
//  Created by Ivan Bruel on 18/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

public class Kitten: NSObject {

  public let name: String

  public init(name: String) {
    self.name = name
  }

  public func meow() -> String {
    return "\(name) meows at you."
  }

}
