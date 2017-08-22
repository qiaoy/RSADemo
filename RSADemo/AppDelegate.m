//
//  AppDelegate.m
//  RSADemo
//
//  Created by 乔岩 on 2017/8/22.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "AppDelegate.h"
#import "QYRSA.h"
#import "Base64.h"

@interface AppDelegate ()

@end

///生成RSA密钥对网址：http://web.chacuo.net/netrsakeypair

static NSString *const kPublicKey = \
                       @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBnf9muY30MbrxIsZU2MBqrx65 \
                         4fAapSL9w/Aqa9AAcPlUwPz+UZ+WXnxTB5JC4GnbGmRIJxMzfBmRN3zegTwv2U8j \
                         DbfKo+oNxzu7xFChERja0n5orK5p5m/pW01pZWW/57m8CuFJQP6qa7v6wHCEznk1 \
                         FgKw1kJ4x/Jf0IMHvQIDAQAB";

static NSString *const kPrivateKey = \
                       @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMGd/2a5jfQxuvEi \
                         xlTYwGqvHrnh8BqlIv3D8Cpr0ABw+VTA/P5Rn5ZefFMHkkLgadsaZEgnEzN8GZE3 \
                         fN6BPC/ZTyMNt8qj6g3HO7vEUKERGNrSfmisrmnmb+lbTWllZb/nubwK4UlA/qpr \
                         u/rAcITOeTUWArDWQnjH8l/Qgwe9AgMBAAECgYAon/Ux4acmYLTf2bMRpHUjLWFe \
                         EUkm3hVsd4tR61M2dH3sSZ4L4qaAj4y4gzMuMxYi8fOuq/w8ZkKbFLBvo2A0MHLe \
                         o7QH2KnDOMUv97yn1bggSwy3ZIJ1WkCqZTYnr0GuDiyYh9D8jvPzYH4TNSn7MKR1 \
                         1IrWeh2FFbPCBzzqAQJBAOnmKhtv6ttVN0HrUIBnpxcEQCsXzeifSQ3IgEao72bL \
                         oKT3WDOAYiDQTbh6OpcB931MOm3PRcnIgBwX+NhiMz0CQQDT6XIOjBg3gfs0YRE8 \
                         VwwQwap5lajfilGEHVYE8DFv5bNcQJSSj6SI0RqyAEfkhwbMhMkxK8jvLHJ6IWlt \
                         P26BAkBRcoF1Hmq0x56/SJa2r+FiRWum1dowx86jiw8IC+mZbQzahPrkrC7/aCm4 \
                         NG/Uh63LptCtzkBp/HSH090mVEOtAkEAsJiPo03edIuOo2Ts7yL/fAtYnMA6nidv \
                         rTChWbYtDLoYkZ2D8utfy2Cu5X3Ua76WzOMvoxmA9shMkji72f4NgQJAT2BBz0fq \
                         DBHhx3vA3KZUwRgbl4m64ZVd5qiVB1UFDlMNcC2uzE3K1eTkc2svjUHaoH5ZG5sW \
                         gwb160/CR9wpDw==";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    QYRSA *rsa = [QYRSA shareInstance];
    // 写入公钥
    [rsa writePukWithKey:kPublicKey];
    [rsa writePrkWithKey:kPrivateKey];
    
    NSString *originStr = @"我们都是好孩子";
    
    // 加密支持中文 不需要转码
    // 加密过程： str -> utf8编码 -> 字符串分割 -> 循环加密 -> 拼接 -> 结果
    // 解密过程： str -> 字符串分割 -> 循环解密 -> 拼接 -> utf8解码 -> 原字符串
    
    NSString *en = [rsa encryptByRsaWith:originStr keyType:(KeyTypePrivate)];
    NSString *de = [rsa decryptByRsaWith:en keyType:(KeyTypePublic)];
    if ([originStr isEqualToString:de]) {
        NSLog(@"originStr = %@ \n>>>>>>>>解密成功!", de);
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
