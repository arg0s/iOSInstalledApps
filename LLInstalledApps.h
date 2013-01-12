//
//  LLInstalledApps.h
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLInstalledApps : NSObject

+ (NSArray *) runningApps;
- (BOOL) appsInstalledWithScheme:(NSString *)applicationScheme;
+ (NSDictionary *) appsInstalledWithSchemes:(NSArray *)applicationSchemes;
+ (NSDictionary* ) appsInstalledWithSchemes:(NSArray *)applicationSchemes withProgressCallback:(void (^)(id))callbackBlock;


@end
