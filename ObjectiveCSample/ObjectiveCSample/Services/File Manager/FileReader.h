//
//  FileReader.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 14/06/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileReader : NSObject

- (void)readJson:(nullable NSString *)fileName withSuccess:(void (^)(NSData *) )successCompletion error:(void (^)(NSError *))errorCompletion;
@end

NS_ASSUME_NONNULL_END
