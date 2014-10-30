//
//  main.m
//  libxml2Test
//
//  Created by lazio14 on 14/10/30.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>

void parseHTML()
{
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        xmlDocPtr doc = xmlNewDoc(BAD_CAST"1.0");
        xmlNodePtr root = xmlNewNode(NULL, BAD_CAST("root"));
        xmlDocSetRootElement(doc, root);
        xmlNewTextChild(root, NULL, BAD_CAST("node"), BAD_CAST("this is a node"));
        int nRet = xmlSaveFile("/Users/lazio14/workplace/github//LibTest/libxml2Test/libxml2Test/test.xml", doc);
        if (nRet != -1) {
            NSLog(@"Create xml success.byte=%d", nRet);
        }
        else
        {
            NSLog(@"Create xml fail");
        }
        
        
        parseHTML();
        NSLog(@"Hello, World!");
    }
    return 0;
}
