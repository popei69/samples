//
//  NetworkService.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "NetworkService.h"

@interface NetworkService()

@property (nonatomic, strong) NSMutableDictionary * tasks;

@end

@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tasks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)getUrl:(NSURL *)url withSuccess:(void (^)(NSData *))successCompletion error:(void (^)(NSError *))errorCompletion { 
    
    NSURLSessionTask * previousTask = [self.tasks objectForKey:url.absoluteString];
    if (previousTask){
        [previousTask cancel];
    }
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            errorCompletion(error);
            return;
        }
        
        if (!data) {
            // TODO create error
            errorCompletion(nil);
            return;
        }
        
        successCompletion(data);
    }];
    
    [task resume];
    [self.tasks setObject:task forKey:url.absoluteString];
}

@end
