//
//  Common+Extensions.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import Foundation

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
}

