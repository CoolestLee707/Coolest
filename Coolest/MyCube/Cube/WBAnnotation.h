//
//  WBAnnotation.h
//  WBCube
//
//  Created by 金修博 on 2019/1/14.
//  Copyright © 2019 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef CubeModSectName
#define CubeModSectName  "CubeMods"
#endif

#ifndef RouterSerSectName
#define RouterSerSectName  "RouterService"
#endif

#ifndef ProtocolSerSectName
#define ProtocolSerSectName  "ProtocolService"
#endif

#ifndef ProtocolSwiftSerSectName
#define ProtocolSwiftSerSectName  "ProSwiftService"
#endif

#ifndef LiChuaminMod
#define LiChuaminMod  "LiChuamin"
#endif


#define CubeDATA(sectname) __attribute__((used, section("__DATA,"#sectname" ")))
#define ServiceDATA(servicename) __attribute__((used, section("__DATA,"#servicename" ")))

/**
 模块注册宏（同步触发模块的init事件）
 @param name 模块名称
 */
#define CubeEvents(name) \
class WBCube; char * k##name##_mod CubeDATA(CubeMods) = ""#name"";

/**
Swift模块Service注册宏
@param mod 模块名称
@param target target名称
*/
#define RouterServiceMap(mod, target) \
class WBCube; char * k##target##_ser ServiceDATA(RouterService) = ""#mod"_"#target"";

/**
 面向协议protocol注册方式--OC
 */
#define RouterProtocolService(servicename,impl) \
class WBCube; char * k##servicename##_ser CubeDATA(ProtocolService) = "{ \""#servicename"\" : \""#impl"\"}";
/**
 面向协议protocol注册方式--Swift
 */
#define RouterSwiftProtocolService(mod,servicename,impl) \
class WBCube; char * k##servicename##_ser CubeDATA(ProSwiftService) = "{ \""#mod"."#servicename"\" : \""#mod"."#impl"\"}";


/**
 测试命令写入
 used是告诉编译器不用优化掉此函数，即使没有地方使用
 */
#define testWriteDATA(authername) __attribute__((used, section("__DATA,"#authername" ")))

#define ModTestDATA(age,address,number) \
class WBCube; char * k##age##_ser testWriteDATA(LiChuamin) = "{ \""#age"."#age"\" : \""#address"_"#number"\"}";

@interface WBAnnotation : NSObject

@end


//__attribute__是编译属性，我们可以通过 __attribute__((section("name")))编译属性将数据写到可执行文件中，然后在使用的时候，从可执行文件中读取出来。
