//
//  FileReader.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 14/06/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "FileReader.h"

@implementation FileReader

- (void)readJson:(nullable NSString *)fileName withSuccess:(void (^)(NSData *) )successCompletion error:(void (^)(NSError *))errorCompletion {
    
    NSError * error;
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:fileName ofType:@"json"];
    
    if (!path) {
        // TODO: handle error
        error = [NSError errorWithDomain:NSCocoaErrorDomain code:998 userInfo:nil];
        errorCompletion(error);
        return;
    }
    
    
    NSData * data = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&error];
    
    if (!data || error) {
        errorCompletion(error);
        return;
    }
    
    successCompletion(data);
}

@end
