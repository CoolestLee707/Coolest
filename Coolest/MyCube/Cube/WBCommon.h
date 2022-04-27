//
//  WBCommon.h
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#ifndef WBCommon_h
#define WBCommon_h

// Debug Logging
#ifdef DEBUG
#define MagicLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define MagicLog(x, ...)
#endif

#endif /* WBCommon_h */
