//
//  AFRequestApi.h
//  AppFrame
//
//  Created by HQ on 2016/12/20.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "YTKRequest.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^AFRequestObjectSuccessBlock)(id responseJOSN,id responseModel);
typedef void(^AFRequestObjectErrorBlock)(NSError* error, NSDictionary* userInfo);

@interface AFRequestApi : YTKRequest

/** 对应返回对象的  Class */
- (Class )responseModelClass;

/** 发请求 */
- (void)startSuccessCall:(AFRequestObjectSuccessBlock)success
             failureCall:(AFRequestObjectErrorBlock)failure;


///  The URL path of request. This should only contain the path part of URL, e.g., /v1/user. See alse `baseUrl`.
///
///  @discussion This will be concated with `baseUrl` using [NSURL URLWithString:relativeToURL].
///              Because of this, it is recommended that the usage should stick to rules stated above.
///              Otherwise the result URL may not be correctly formed. See also `URLString:relativeToURL`
///              for more information.
///
///              Additionaly, if `requestUrl` itself is a valid URL, it will be used as the result URL and
///              `baseUrl` will be ignored.
- (NSString *)requestUrl;

///  Optional CDN URL for request.
- (NSString *)cdnUrl;

///  Requset timeout interval. Default is 60s.
///
///  @discussion When using `resumableDownloadPath`(NSURLSessionDownloadTask), the session seems to completely ignore
///              `timeoutInterval` property of `NSURLRequest`. One effective way to set timeout would be using
///              `timeoutIntervalForResource` of `NSURLSessionConfiguration`.
- (NSTimeInterval)requestTimeoutInterval;

///  Additional request argument.
- (nullable id)requestArgument;

///  Should use CDN when sending request.
- (BOOL)useCDN;

@end
NS_ASSUME_NONNULL_END
