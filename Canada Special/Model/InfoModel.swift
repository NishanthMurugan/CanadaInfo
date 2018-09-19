//
//  InfoModel.swift
//  Canada Special
//
//  Created by Nishanth Murugan on 19/09/18.
//  Copyright © 2018 WIPRO. All rights reserved.
//

import Foundation

struct InfoModel: Codable {
    let title : String?
    let rows : [RowsModel?]
}

struct RowsModel: Codable {
    let title : String?
    let description : String?
    let imageHref : String?
}
