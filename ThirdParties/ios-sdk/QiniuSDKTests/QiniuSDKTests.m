//
//  QiniuSDKTests.m
//  QiniuSDKTests
//
//  Created by Qiniu Developers 2013
//

#import "QiniuSDKTests.h"
#import "QiniuConfig.h"
#import <zlib.h>

#define kWaitTime 400 // seconds

@implementation QiniuSDKTests

- (void)setUp
{
    [super setUp];
    
    _filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test1.png"];
    _fileMedium = [NSTemporaryDirectory() stringByAppendingPathComponent:@"medium.mp4"];
    _fileLarge = [NSTemporaryDirectory() stringByAppendingPathComponent:@"large.mp4"];
    NSLog(@"Test file: %@", _filePath);
    
    // Download a file and save to local path.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:_filePath])
    {
        NSURL *url = [NSURL URLWithString:@"http://qiniuphotos.qiniudn.com/gogopher.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:_filePath atomically:TRUE];
    }
    
    if (![fileManager fileExistsAtPath:_fileMedium])
    {
        NSURL *url = [NSURL URLWithString:@"http://shars.qiniudn.com/outcrf.mp4"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:_fileMedium atomically:TRUE];
    }
    
    // Prepare the uptoken
    // token with a year, 14.2.23
    _token = @"6UOyH0xzsnOF-uKmsHgpi7AhGWdfvI8glyYV3uPg:m-8jeXMWC-4kstLEHEMCfZAZnWc=:eyJkZWFkbGluZSI6MTQyNDY4ODYxOCwic2NvcGUiOiJ0ZXN0MzY5In0=";
    
    _done = false;
    _progressReceived = false;
}

- (void)tearDown
{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [fileManager removeItemAtPath:_filePath error:Nil];
    
    // Tear-down code here.
    [super tearDown];
}


// Upload progress
- (void)uploadProgressUpdated:(NSString *)theFilePath percent:(float)percent
{
    _progressReceived = YES;
    NSLog(@"Progress Updated: %@ - %f", theFilePath, percent);
}
// */

// Upload completed successfully
- (void)uploadSucceeded:(NSString *)theFilePath ret:(NSDictionary *)ret
{
    _done = YES;
    _succeed = YES;
    _retDictionary = ret;
    NSLog(@"Upload Succeeded: %@ - Ret: %@", theFilePath, ret);
}

// Upload failed
- (void)uploadFailed:(NSString *)theFilePath error:(NSError *)error
{
    _done = YES;
    _error = error;
    NSLog(@"Upload Failed: %@ - Reason: %@", theFilePath, error);
    NSString *reqid = [error.userInfo valueForKey:@"reqid"];
    XCTAssertFalse(reqid == nil, @"no reqid");
}

- (NSString *) timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd-HH-mm-ss-zzz"];
    return [formatter stringFromDate:[NSDate date]];
}

- (void) waitFinish {
    int waitLoop = kWaitTime;
    while (!_done && waitLoop > 0) // Wait for 10 seconds.
    {
//        NSLog(@"Waiting for the result...");
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        waitLoop--;
    }
    if (waitLoop <= 0) {
        XCTFail(@"Failed to receive expected delegate messages.");
    }
}

- (void) testUploadData
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    NSData *data = [NSData dataWithContentsOfFile:_filePath];
    [uploader uploadFileData:data key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "UploadData failed, error: %@", _error);
}

- (void) testUploadDataWithoutKey
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    NSData *data = [NSData dataWithContentsOfFile:_filePath];
    [uploader uploadFileData:data key:nil extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "UploadData failed, error: %@", _error);
}

- (void) testSimpleUpload
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "SimpleUpload failed, error: %@", _error);
}

- (void) testSimpleUploadRetry
{
    NSString *upTmp = kQiniuUpHosts[0];
    kQiniuUpHosts[0] = @"http://127.0.0.1";

    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "SimpleUpload failed, error: %@", _error);
    
    kQiniuUpHosts[0] = upTmp;
}


- (void) testSimpleUploadFailed
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:@""];
    uploader.delegate = self;
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(NO, NO, "SimpleUpload should failed, error: %@", _error);
}


- (void) testSimpleUploadWithUndefinedKey
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    [uploader uploadFile:_filePath key:kQiniuUndefinedKey extra:nil];
    [self waitFinish];
}


- (void) testSimpleUploadWithReturnBodyAndUserParams
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    
    // extra argument
    QiniuPutExtra *extra = [[QiniuPutExtra alloc] init];
    extra.params = @{@"x:foo": @"fooName"};
    
    // upload
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:extra];
    [self waitFinish];
}

- (void) testSimpleUploadWithWrongCrc32
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    
    // wrong crc32 value
    QiniuPutExtra *extra = [[QiniuPutExtra alloc] init] ;
    extra.crc32 = 123456;
    extra.checkCrc = 1;
    
    // upload
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:extra];
    [self waitFinish];
}

- (void)testResumableUploadSmall
{
    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    
    NSLog(@"resumable upload");
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);
}

- (void)testResumableUploadSmallRetry
{
    NSString *upTmp = kQiniuUpHosts[0];
    kQiniuUpHosts[0] = @"http://127.0.0.1";

    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    
    NSLog(@"resumable upload");
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);

    kQiniuUpHosts[0] = upTmp;

}


- (void)testResumableUploadWithoutKey
{
    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    
    NSLog(@"resumable upload");
    [uploader uploadFile:_filePath key:nil extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);
}


- (void)testResumableUploadWithParam
{
    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"iamaiosdeveloper" forKey:@"x:cus"];
    QiniuRioPutExtra *extra = [QiniuRioPutExtra extraWithParams:params];
    extra.notify = ^(int blockIndex, int blockSize, QiniuBlkputRet* ret) {
        NSLog(@"notify for data persistence, blockIndex:%d, blockSize:%d, offset:%d ctx:%@",
              blockIndex, blockSize, (unsigned int)ret.offset, ret.ctx);
    };
    extra.notifyErr = ^(int blockIndex, int blockSize, NSError* error) {
        NSLog(@"notify for block upload failed, blockIndex:%d, blockSize:%d, error:%@",
              blockIndex, blockSize, error);
    };
    extra.concurrentNum = 1;

    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-params-%@.png", [self timeString]] extra:extra];

    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);
    XCTAssertEqualObjects(@"iamaiosdeveloper", [_retDictionary objectForKey:@"x:cus"], "x:cus not equal");
}

- (void)testResumableUploadMedium
{
    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    
    [uploader uploadFile:_fileMedium key:[NSString stringWithFormat:@"test-medium-%@.mp4", [self timeString]] extra:nil];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);
}

- (void)testEncodeExtra
{
    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
    uploader.delegate = self;
    QiniuRioPutExtra *extra = [[QiniuRioPutExtra alloc] init];
    extra.notify = ^(int blockIndex, int blockSize, QiniuBlkputRet* ret) {
        NSLog(@"[testEncodeExtra]notify for data persistence, blockIndex:%d, blockSize:%d, offset:%d ctx:%@",
              blockIndex, blockSize, (unsigned int)ret.offset, ret.ctx);
    };
    
    NSString *key = [NSString stringWithFormat:@"test-encode-extra-%@.mp4", [self timeString]];
    [uploader uploadFile:_fileMedium key:key extra:extra];
    
    NSData *serialized;
    int loop = 40;
    while (loop > 0) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        if (extra.uploadedBlockNumber > 0) {
            [extra cancelTasks];
            serialized = [NSKeyedArchiver archivedDataWithRootObject:extra];
            NSLog(@"extra.uploadedBlockNumber: %d", (unsigned int)extra.uploadedBlockNumber);
            break;
        }
        loop--;
    }
    if (loop == 0) {
        XCTFail(@"upload block time out");
    }

    QiniuRioPutExtra *newExtra = [NSKeyedUnarchiver unarchiveObjectWithData:serialized];
    newExtra.notify = ^(int blockIndex, int blockSize, QiniuBlkputRet* ret) {
        NSLog(@"[testEncodeExtra,new]notify for data persistence, blockIndex:%d, blockSize:%d, offset:%d ctx:%@",
              blockIndex, blockSize, (unsigned int)ret.offset, ret.ctx);
        XCTAssertTrue([extra.progresses[blockIndex] isKindOfClass:[NSNull class]], @"index of progresses should be nil, index: %d", blockIndex);
    };

    [uploader uploadFile:_fileMedium key:key extra:newExtra];
    [self waitFinish];
    XCTAssertEqual(_succeed, YES, "ResumableUpload reuse extra failed, error: %@", _error);
}

//- (void)testResumableUploadLarge
//{
//    @autoreleasepool {
//        
//    
//    QiniuResumableUploader *uploader = [[QiniuResumableUploader alloc] initWithToken:_token];
//    uploader.delegate = self;
//    
//    [uploader uploadFile:_fileLarge key:[NSString stringWithFormat:@"test-large-%@", [self timeString]] extra:nil];
//    }
//    
//    [self waitFinish];
//    
//    XCTAssertEqual(_succeed, YES, "ResumableUpload failed, error: %@", _error);
//}


/*
- (void) testSimpleUploadWithRightCrc32
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:_token];
    uploader.delegate = self;
    
    // calc right crc32 value
    NSData *buffer = [NSData dataWithContentsOfFile:_filePath];
    uLong crc = crc32(0L, Z_NULL, 0);
    crc = crc32(crc, [buffer bytes], [buffer length]);
    
    // extra argument with right crc32
    QiniuPutExtra *extra = [[QiniuPutExtra alloc] init];
    extra.crc32 = crc;
    extra.checkCrc = 1;
    
    // upload
    [uploader uploadFile:_filePath key:[NSString stringWithFormat:@"test-%@.png", [self timeString]] extra:extra];
    [self waitFinish];
}
 */

@end
