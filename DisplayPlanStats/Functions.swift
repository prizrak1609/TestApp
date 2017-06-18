//
//  Functions.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 19.06.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

#if DEBUG
    import SwiftyBeaver
#endif

/// log something generally unimportant (lowest priority)
func v(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
        SwiftyBeaver.verbose(message, file, function, line: line)
    #endif
}

/// log something which help during debugging (low priority)
func d(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
        SwiftyBeaver.debug(message, file, function, line: line)
    #endif
}

/// log something which you are really interested but which is not an issue or error (normal priority)
func i(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
        SwiftyBeaver.info(message, file, function, line: line)
    #endif
}

/// log something which may cause big trouble soon (high priority)
func w(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
        SwiftyBeaver.warning(message, file, function, line: line)
    #endif
}

/// log something which will keep you awake at night (highest priority)
func e(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line) {
    #if DEBUG
        SwiftyBeaver.error(message, file, function, line: line)
    #endif
}
