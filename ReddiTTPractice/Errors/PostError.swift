//
//  PostError.swift
//  ReddiTTPractice
//
//  Created by Nick Reichard on 1/23/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

enum PostError: Error {
    case optionalUrl
    case cannotParseJson
}
