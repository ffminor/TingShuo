//
//  TSGlobalDataCache.m
//  TingShuo
//
//  Created by fminor on 8/18/14.
//
//

#import "TSGlobalDataCache.h"

@implementation TSGlobalDataCache

#pragma mark - init and dealloc

- (id)initWithFilePath:(NSString *)filePath
{
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    _filePath = filePath;
    
    return self;
}

#pragma mark - internal methods

- (void)_initFile:(NSString *)filePath
{
    // find document path
    
    // NSString *_homepath = NSHomeDirectory();
    NSArray *_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_docPath = [_paths lastObject];
    
    // concat path
    NSString *_realFilePath = [_docPath stringByAppendingString:filePath];
    NSFileHandle *_fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:_realFilePath];
}

@end
