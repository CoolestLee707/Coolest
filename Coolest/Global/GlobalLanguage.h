//
//  GlobalLanguage.h
//  Coolest
//
//  Created by daoj on 2019/5/22.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#ifndef GlobalLanguage_h
#define GlobalLanguage_h


///设置多语言
#define ADSetLocalLanguage(Language) \
[[NSUserDefaults standardUserDefaults] setObject:Language forKey:APPLanguageKey];\
[[NSUserDefaults standardUserDefaults] synchronize];

///多语言加载文字
#define ADLocalizedString(key) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:APPLanguageKey]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]



#endif /* GlobalLanguage_h */
