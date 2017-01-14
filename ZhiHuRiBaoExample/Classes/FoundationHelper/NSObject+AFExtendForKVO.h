//
//  NSObject+AFExtendForKVO.h
//  AppFrame
//
//  Created by HQ on 2016/12/21.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AFExtendForKVO)
/**
 Registers a block to receive KVO notifications for the specified key-path
 relative to the receiver.

 @discussion The block and block captured objects are retained. Call
 `removeObserverBlocksForKeyPath:` or `removeObserverBlocks` to release.

 @param keyPath The key path, relative to the receiver, of the property to
 observe. This value must not be nil.

 @param block   The block to register for KVO notifications.
 */
- (void)af_addObserverBlockForKeyPath:(NSString*)keyPath
                             block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications for the property specified by a given key-path
 relative to the receiver, and release these blocks.

 @param keyPath A key-path, relative to the receiver, for which blocks is
 registered to receive KVO change notifications.
 */
- (void)af_removeObserverBlocksForKeyPath:(NSString*)keyPath;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications, and release these blocks.
 */
- (void)af_removeObserverBlocks;




/// 获取字符串
@property (copy, nonatomic, readonly) NSString* af_toSafeString;

@end

NS_ASSUME_NONNULL_END
