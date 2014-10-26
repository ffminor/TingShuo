//
//  TSKeySignature.h
//  TingShuo
//
//  Created by fminor on 10/27/14.
//
//

#import <Foundation/Foundation.h>

@interface TSKeySignature : NSObject

+ (NSData *) hmacSha1:(NSString*)key text:(NSString*)text;

@end
