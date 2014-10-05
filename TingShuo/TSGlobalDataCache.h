//
//  TSGlobalDataCache.h
//  TingShuo
//
//  Created by fminor on 8/18/14.
//
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface TSGlobalDataCache : NSObject
{
    NSString                    *_filePath;
}

/*
 Set file path
 */
- (id)initWithFilePath:(NSString *)filePath;

/*
 Get and unarchive an object for a given key
 */
- (NSObject *)objectForKey:(NSString *)key;

/*
 Set and archive
 */
- (void)setObject:(NSObject *)data forKey:(NSString *)key;

@end
