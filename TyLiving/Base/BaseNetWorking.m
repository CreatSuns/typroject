//
//  BaseNetWorking.m
//  WYAiOSEnv
//
//  Created by 李世航 on 2018/7/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "BaseNetWorking.h"

// 默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 100;

@implementation BaseNetWorking

#pragma mark - Public Method

+ (void)GetWithUrl:(NSString *)urlString
            params:(NSMutableDictionary *)params
           success:(Success)success
              fail:(Fail)fail {
    AFHTTPSessionManager * manager    = [self AFManager];
    AFHTTPRequestSerializer * request = [AFHTTPRequestSerializer serializer];
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    NSString * sysVersion  = [[UIDevice currentDevice] systemVersion];
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * appVersion  = [infoDic objectForKey:@"CFBundleShortVersionString"];
    [request setValue:appVersion forHTTPHeaderField:@"version"];
    [request setValue:[NSString stringWithFormat:@"ios%@", sysVersion] forHTTPHeaderField:@"platform"];
    

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    manager.requestSerializer = request;
    NSLog(@"<<<<<<<<<<<<<<<<<<<<");
    NSLog(@"本次Get请求URL:%@",urlString);
    NSLog(@"本次Get请求的Headers:%@",request.HTTPRequestHeaders);
    NSLog(@"本次Get请求的参数:%@",params);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<");
    [manager GET:urlString parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(jsonObj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error.localizedDescription);
    }];
}

+ (void)PostWithUrl:(NSString *)urlString
       headerParams:(NSMutableDictionary *)headerParams
             params:(NSMutableDictionary *)params
            success:(Success)success
               fail:(Fail)fail {
    AFHTTPSessionManager * manager = [self AFManager];
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }

    // 上传JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (headerParams) {
        for (NSString * key in headerParams.allKeys) {
            [manager.requestSerializer setValue:headerParams[key] forHTTPHeaderField:key];
        }
    } else {
        NSString * sysVersion  = [[UIDevice currentDevice] systemVersion];
        NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString * appVersion  = [infoDic objectForKey:@"CFBundleShortVersionString"];
        [manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"version"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"ios%@", sysVersion] forHTTPHeaderField:@"platform"];
    }

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"<<<<<<<<<<<<<<<<<<<<");
    NSLog(@"本次Post请求URL:%@",urlString);
    NSLog(@"本次Post请求的Headers:%@",manager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"本次Post请求的参数:%@",params);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<");
    [manager POST:urlString
       parameters:params
          headers:nil
         progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        success(jsonObj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error.localizedDescription);
    }];

}

+ (void)UploadImageWithUrl:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    images:(NSArray<UIImage *> *)images
                imageNames:(NSArray<NSString *> *)imageNames
                 imageType:(ImageType)type
     imageCompressionRatio:(float)ratio
                  progress:(Progress)progress
                   success:(Success)success
                      fail:(Fail)fail {
    if (images.count == 0) {
        fail(@"上传图片个数不能小于1个");
        return;
    }

    AFHTTPSessionManager * manager = [self AFManager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

    [manager POST:urlString
        parameters:params
          headers:nil
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            for (NSInteger i = 0; i < images.count; i++) {
                UIImage * image = images[i];

                //                NSData * data;
                //                NSString * imageType;
                //                switch (type) {
                //                    case imageForPNG:
                //                        data      = UIImagePNGRepresentation(image);
                //                        imageType = @"image/png";
                //                        break;
                //                    case imageForJPEG:
                //                        data      = UIImageJPEGRepresentation(image, ratio);
                //                        imageType = @"image/jpeg";
                //                        break;
                //                    default:
                //                        break;
                //                }
                NSData * turnData;
                NSString * imageType;
                NSData * data = UIImagePNGRepresentation(image);
                turnData      = data;
                imageType     = @"image/png";
                //                if (data.length > 1024 * 1024) {
                //                    turnData  = UIImageJPEGRepresentation(image, 0.6);
                //                    imageType = @"image/jpeg";
                //                } else {

                //                }
                [formData appendPartWithFileData:turnData name:@"file" fileName:imageNames[i] mimeType:imageType];
            }

        }
        progress:^(NSProgress * _Nonnull uploadProgress) {

            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

#pragma mark - Getter
+ (AFHTTPSessionManager *)AFManager {
    static AFHTTPSessionManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        // 超过时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        // 声明获取到的数据格式
        // AFN不会解析,数据是data，需要自己解析
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        // AFN会JSON解析返回的数据
        //        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/xml", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"text/xml", nil];

    });
    return manager;
}
@end
/*
 + (void)UploadVideoWithUrl:(NSString *)urlString
 params:(NSMutableDictionary *)params
 videoPaths:(NSArray *)videoPaths
 videoNames:(NSArray *)videoNames
 progress:(Progress)progress
 success:(Success)success
 fail:(Fail)fail {
 if (videoPaths.count == 0) {
 fail(@"上传视频个数不能小于1个");
 return;
 }

 AFHTTPSessionManager * manager = [self AFManager];

 [manager POST:urlString
 parameters:params
 constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

 for (NSInteger i = 0; i < videoPaths.count; i++) {
 NSString * path = videoPaths[i];

 NSError * error;

 [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"Filedata" fileName:videoNames[i] mimeType:@"application/octet-stream" error:&error];
 if (error) {
 fail(error.localizedDescription);
 return;
 }
 }

 }
 progress:^(NSProgress * _Nonnull uploadProgress) {

 progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

 }
 success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

 id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

 success(jsonObj);

 }
 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

 fail(error.localizedDescription);

 }];
 }

 + (void)UploadFileWithUrl:(NSString *)urlString
 params:(NSMutableDictionary *)params
 filePaths:(NSArray *)filePaths
 fileNames:(NSArray *)fileNames
 progress:(Progress)progress
 success:(Success)success
 fail:(Fail)fail {
 if (filePaths.count == 0) {
 fail(@"上传文件个数不能小于1个");
 return;
 }

 AFHTTPSessionManager * manager = [self AFManager];

 [manager POST:urlString
 parameters:params
 constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

 for (NSInteger i = 0; i < filePaths.count; i++) {
 NSString * path = filePaths[i];

 NSError * error;

 [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"Filedata" fileName:fileNames[i] mimeType:@"application/octet-stream" error:&error];
 if (error) {
 fail(error.localizedDescription);
 return;
 }
 }

 }
 progress:^(NSProgress * _Nonnull uploadProgress) {

 progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

 }
 success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

 id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

 success(jsonObj);

 }
 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

 fail(error.localizedDescription);

 }];
 }

 + (NSURLSessionDownloadTask *)DownloadFileWithUrl:(NSString *)urlString
 params:(NSMutableDictionary *)params
 filePath:(NSString *)filePath
 progress:(Progress)progress
 success:(Success)success
 fail:(Fail)fail {
 AFHTTPSessionManager * manager          = [self AFManager];
 urlString                               = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
 NSURLRequest * reuqest                  = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
 NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:reuqest
 progress:^(NSProgress * _Nonnull downloadProgress) {
 float number = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
 NSLog(@"number==%f", number);
 progress(number);

 }
 destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
 return [NSURL fileURLWithPath:filePath];
 }
 completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

 NSLog(@"jsonobj==%@", response);
 NSLog(@"error==%@", error);
 NSLog(@"filep==%@", filePath);
 if (error) {
 fail(@"下载失败");
 } else {
 success(@"下载成功");
 }

 }];

 return downloadTask;
 }
 */
