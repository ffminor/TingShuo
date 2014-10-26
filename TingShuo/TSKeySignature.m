//
//  TSKeySignature.m
//  TingShuo
//
//  Created by fminor on 10/27/14.
//
//

#import "TSKeySignature.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation TSKeySignature

+ (NSData *) hmacSha1:(NSString*)key text:(NSString*)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    NSData *_data = [NSData dataWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    return _data;
}

@end
