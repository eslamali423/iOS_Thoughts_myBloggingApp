//
//  Global.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import Foundation



func fileNameFromUrl(fileUrl : String) -> String {
    let name = fileUrl.components(separatedBy: "_").last
    let name1 =  name?.components(separatedBy: "?").first
    let name2 = name1?.components(separatedBy: ".").first
    return name2!
}
