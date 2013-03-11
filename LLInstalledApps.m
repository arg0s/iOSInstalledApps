//
//  LLInstalledApps.m
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import "LLInstalledApps.h"
#import <sys/sysctl.h>

@implementation LLInstalledApps

static LLInstalledApps *singleton= nil;

+ (LLInstalledApps *)sharedInstance
{
    if (singleton == nil) {
        singleton = [[LLInstalledApps alloc] init];
    }
    return singleton;
}

- (NSArray *) _sysctl_ps {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        size += size / 10;
        newprocess = realloc(process, size);
        if (!newprocess){
            if (process){
                free(process);
            }
            return nil;
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            if (nprocess){
                NSMutableArray * array = [[NSMutableArray alloc] init];
                for (int i = nprocess - 1; i >= 0; i--){
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil] forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                    [array addObject:dict];
                }
                free(process);
                return array; 
            }
        }
    }
    
    return nil;
}

+ (NSArray *) runningApps{
    
    NSArray* foo = [[LLInstalledApps sharedInstance] _sysctl_ps];
    assert(foo);
    NSMutableArray* processes = [NSMutableArray array];
    for (NSDictionary* spam in foo) {
        [processes addObject:[spam objectForKey:@"ProcessName"]];
    }
    return [NSArray arrayWithArray:processes];
}

- (BOOL) appsInstalledWithScheme:(NSString *)applicationScheme {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:applicationScheme]];
}


+ (NSDictionary* ) appsInstalledWithSchemes:(NSArray *)applicationSchemes {
    LLInstalledApps* instance = [LLInstalledApps sharedInstance];
    NSMutableDictionary* dict = [@{} mutableCopy];
    for (NSString* scheme in applicationSchemes) {
        [dict setObject:[NSNumber numberWithBool:
                         [instance appsInstalledWithScheme:scheme]]
                 forKey:scheme];
    }
    return dict;
}

+ (NSDictionary* ) appsInstalledWithSchemes:(NSArray *)applicationSchemes withProgressCallback:(void (^)(id))callbackBlock{
    LLInstalledApps* instance = [LLInstalledApps sharedInstance];
    NSMutableDictionary* dict = [@{} mutableCopy];
    
    [applicationSchemes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* scheme = obj;
        [dict setObject:[NSNumber numberWithBool:
                         [instance appsInstalledWithScheme:scheme]]
                 forKey:scheme];
        callbackBlock([NSNumber numberWithInteger:idx]);
    }];
    return dict;
}

+ (NSArray* ) appsInstalledWithSchemes:(NSArray *)applicationSchemes withProgressCallback:(void (^)(id))callbackBlock maxSize:(int) maxSize{
    LLInstalledApps* instance = [LLInstalledApps sharedInstance];
    NSMutableArray* installed_schemes = [@[] mutableCopy];
    
    [applicationSchemes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* scheme = obj;
        if([installed_schemes count]>maxSize){
            *stop=YES;
            return;
        }
        if ([instance appsInstalledWithScheme:scheme]) {
            [installed_schemes addObject:scheme];
        }
        callbackBlock([NSNumber numberWithInteger:idx]);
    }];
    return installed_schemes;
}



@end
