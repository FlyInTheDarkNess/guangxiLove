//
//  model.m
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "gongnengmodel.h"

@implementation gongnengmodel
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    gongnengmodel * mode = [[gongnengmodel alloc]init];
    [mode setValuesForKeysWithDictionary:dictionary];
    return mode;
}

//model中id的处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    //    if ([key isEqualToString:@"id"]) {
    //
    //        self.ID = value;
    //    }
    
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    
    //    if ([keyPath isEqualToString:@"id"]) {
    //
    //        self.ID = value;
    //    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
