//
//  NSObject+ZRDebug.m
//  ZRObjcKit
//
//  Created by jiaxw-mac on 2017/12/23.
//  Copyright © 2017年 jiaxw. All rights reserved.
//

#import "NSObject+ZRDebug.h"
#import <objc/runtime.h>
#import "ZRPerson.h"

@implementation NSObject (ZRDebug)

+ (void)zr_debugVariables:(BOOL)includeSuperVariables{
    unsigned int count = 0;
    Class cls = self;
    BOOL stop = NO;
    printf("\n==============BEGIN LOG <%s> VARS==============\n",class_getName(self));
    while (cls != nil && NO == stop) {
        Ivar *varList = class_copyIvarList(cls, &count);
        printf("%s(%i):\n",class_getName(cls),count);
        for (unsigned int i = 0; i < count; i++) {
            Ivar var = varList[i];
            printf("\t%s\t",ivar_getName(var));
            printf("\t%s\n",ivar_getTypeEncoding(var));
        }
        cls = [cls superclass];
        stop = !includeSuperVariables;
        free(varList);
    }
    printf("==============END   LOG <%s> VARS==============\n",class_getName(self));
}


+ (void)zr_debugInstanceVarInfoByName:(NSString *)name{
    
    Ivar var = class_getInstanceVariable(self, [name UTF8String]);
    printf("name: %s\n",ivar_getName(var));
    printf("offset: %zd\n", ivar_getOffset(var));
    printf("type encoding: %s\n",ivar_getTypeEncoding(var));
}

+ (void)zr_debugClassVarInfoByName:(NSString *)name{
    Ivar var = class_getClassVariable(self, [name UTF8String]);
    printf("name: %s\n",ivar_getName(var));
    printf("offset: %zd\n", ivar_getOffset(var));
    printf("type encoding: %s\n",ivar_getTypeEncoding(var));
}


+ (void)zr_debugProperties:(BOOL)includeSuperProperties{
    unsigned int count = 0;
    Class cls = self;
    BOOL stop = NO;
    printf("\n==============BEGIN LOG <%s> PROPERTIES==============\n",class_getName(self));
    while (cls != nil && NO == stop) {
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        printf("%s(%i):\n",class_getName(cls),count);
        for (unsigned int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            //获取属性名
            printf("\t%s\t", property_getName(property));
            //获取属性描述字符串
            printf("\t%s\n", property_getAttributes(property));
        }
        cls = [cls superclass];
        stop = !includeSuperProperties;
        free(properties);
    }
    printf("==============END   LOG <%s> PROPERTIES==============\n",class_getName(self));
}


+ (void)zr_debugPropertyInfoByName:(NSString *)name{
    //获取类指定的属性
    objc_property_t property = class_getProperty(self, [name UTF8String]);
    
    //获取属性的特性列表，并遍历
    unsigned int count = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_attribute_t attribute = attributes[i];
        printf("name = %s, value = %s\n",attribute.name,attribute.value);
    }
    free(attributes);
    
//    //获取属性指定特性值
//    char *property_attribute = property_copyAttributeValue(property, "T");
//    printf("%s\n",property_attribute);
//    free(property_attribute);
}


+ (void)zr_debugInstanceMethods:(BOOL)includeSuperMethods{
    Class cls = self;
    printf("\n==============BEGIN LOG <%s> INSTANCE METHODS==============\n",class_getName(cls));
    [self zr_methodsForClass:cls includeSuperMethods:includeSuperMethods];
    printf("==============END   LOG <%s> INSTANCE METHODS==============\n",class_getName(cls));
}

+ (void)zr_debugClassMethods:(BOOL)includeSuperMethods{
    const char *clsName = class_getName(self);
    Class cls = objc_getMetaClass(clsName);
    printf("\n==============BEGIN LOG <%s> CLASS METHODS==============\n", clsName);
    [self zr_methodsForClass:cls includeSuperMethods:includeSuperMethods];
    printf("==============END   LOG <%s> CLASS METHODS==============\n", clsName);
}

+ (void)zr_methodsForClass:(Class)cls includeSuperMethods:(BOOL)includeSuperMethods{
    unsigned int count = 0;
    BOOL stop = NO;
    while (cls != nil && NO == stop) {
        Method *methodList =class_copyMethodList(cls, &count);
        const char *clsName = class_getName(cls);
        printf("%s(%i):\n",clsName,count);
        for (unsigned int i = 0; i < count; i++) {
            SEL sel = method_getName(methodList[i]);
            const char *typeEncoding = method_getTypeEncoding(methodList[i]);
            printf("\t%s\t%s\n", sel_getName(sel),typeEncoding);
        }
        
        if (class_isMetaClass(cls) &&
            (0 == strcmp(clsName, class_getName([NSObject class])))) {
            stop = YES;
            continue;
        }
        
        cls = [cls superclass];
        stop = !includeSuperMethods;
        
        free(methodList);
    }
}


+ (void)zr_debugProtocols:(BOOL)includeSuperProtocols{
    unsigned int count;
    Class cls = self;
    BOOL stop = NO;
    printf("\n==============BEGIN LOG <%s> PROTOCOLS==============\n",class_getName(self));
    while (cls != nil && NO == stop) {
        Protocol * __unsafe_unretained *protocols = class_copyProtocolList(cls, &count);
        printf("%s(%i):\n",class_getName(cls),count);
        for (int i = 0; i < count; i ++) {
            const char *protocolName = protocol_getName(protocols[i]);
            printf("\t%s\n", protocolName);
        }
        cls = [cls superclass];
        stop = !includeSuperProtocols;
        free(protocols);
    }
    printf("==============END   LOG <%s> PROTOCOLS==============\n",class_getName(self));
}

@end
