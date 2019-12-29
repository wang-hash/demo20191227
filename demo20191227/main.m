//
//  main.m
//  demo20191227
//
//  Created by wangjingru on 2019/12/27.
//  Copyright © 2019 wangjingru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface someObject : NSObject
@end

@implementation someObject: NSObject

-(id) init{
    if(self = [super init]){
        NSLog(@"someObject init");
    }
    
    return self;
}

-(void) dealloc{
    NSLog(@"someObject dealloc");
}

@end

int main(int argc, const char* argv[]){
    
    {
        //取得非自己生成并持有的对象
        id __strong obj = [NSMutableArray array];
    }
    
    NSLog(@"1 finish");
    
    {
        //自己生成并持有对象
        id __strong obj = [[NSObject alloc] init];
    }
    NSLog(@"2 finish");
    
    id __strong obj0 = [[someObject alloc] init];
    id __strong obj1 = [[someObject alloc] init];
    id __strong obj2 = nil;
    
    obj1 = obj0;
    obj2 = obj1;
    obj0 = nil;
    obj1 = nil;
    obj2 = nil;
    
    /*
        id __weak obj = [[NSObject alloc] init];
        编译出错，weak不能持有对象实例，生成的对象会立即被释放，
     */
    id __weak obj = nil;
    {
        id __strong obj0 = [[NSObject alloc] init];
        
        obj = obj0;
        NSLog(@" %@", obj0);
    }
    
    NSLog(@"%@", obj);//若weak持有的对象被废弃，则此引用将自动失效且处于nil被赋值的状态，索引此时obj为nil
    
    
    id __unsafe_unretained unsafe_obj = nil;
    {
        id __strong obj0 = [[NSObject alloc] init];
        unsafe_obj = obj0;
        
        NSLog(@"%@", unsafe_obj);
    }
     NSLog(@"%@", unsafe_obj);//__unsafe_unretained同__weak修饰符的变量一样，因为自己生成并持有的对象不能继续为自己所有，所以生成的对象会立即被释放。
    //两次结果相同，所以__unsafe_unretained修饰符变量的对象在通过该变量使用时，如果没有确保其确实存在，那么应用程序就会崩溃。
    
    
    {
        /*
        id obj0 = [[someObject alloc] init];
        id __weak obj1 = obj0;
        NSLog(@"class=%@", [obj1 class]);
        */
       
        
        id __weak obj1 = obj0;
        id __autoreleasing tmp = obj1;
        NSLog(@"class=%@", [tmp class]);
        
        //以上两种代码相同，
    }
    return 0;
}
