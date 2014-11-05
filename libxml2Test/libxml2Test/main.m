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
#include <libxml2/libxml/xpath.h>
#import "TFHpple.h"

void createSimpleXML(char* xmlPath)
{
    // create a xml like this:
    // <?xml version="1.0"?>
    // <root><node>this is a node</node></root>
    
    xmlDocPtr doc = xmlNewDoc(BAD_CAST"1.0");
    xmlNodePtr root = xmlNewNode(NULL, BAD_CAST("root"));
    xmlDocSetRootElement(doc, root);
    xmlNewTextChild(root, NULL, BAD_CAST("node"), BAD_CAST("this is a node"));
    int nRet = xmlSaveFile(xmlPath, doc);
    if (nRet != -1) {
        NSLog(@"Create xml success.byte=%d", nRet);
    }
    else
    {
        NSLog(@"Create xml fail");
    }
}

void parseXML(char* xmlPath)
{
    // parse xml file like this:
    // <?xml version="1.0"?>
    // <root><node>this is a node</node></root>
    xmlDocPtr doc = xmlParseFile(xmlPath);
    
    xmlXPathContextPtr context = xmlXPathNewContext(doc);
    xmlXPathObjectPtr result = xmlXPathEvalExpression((xmlChar*)("/root/node"), context);
    if(xmlXPathNodeSetIsEmpty(result->nodesetval))
    {
        NSLog(@"result is empty");
    }
    else
    {
        xmlNodeSetPtr nodeset = result->nodesetval;
        for (int i=0; i < nodeset->nodeNr; i++)
        {
            xmlChar* keyword = xmlNodeListGetString(doc, nodeset->nodeTab[i]->xmlChildrenNode, 1);
            NSLog(@"%s", keyword);
        }
    }
    xmlXPathFreeObject (result); //释放内存
    xmlCleanupParser();//清除由libxml2申请的内存
    xmlFreeDoc(doc);
}

// parse the html file in http://makesmethink.com
void parseMMTHTML(NSString* htmlPath)
{
    NSData  * data      = [NSData dataWithContentsOfFile:htmlPath];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements  = [doc searchWithXPathQuery:@"//body//div[@class='post']//p//a"];
    
    NSInteger len = [elements count];
    for (NSInteger i = 0; i < len; i++) {
        TFHppleElement * element = [elements objectAtIndex:i];
        NSLog(@"%@\n", [element text]);                       // The text inside the HTML element (the content of the first text node)
        
        [element tagName];                    // "a"
        [element attributes];                 // NSDictionary of href, class, id, etc.
        [element objectForKey:@"href"];       // Easy access to single attribute
        [element firstChildWithTagName:@"b"]; // The first "b" child node
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        createSimpleXML("/Users/lazio14/workplace/github//LibTest/libxml2Test/libxml2Test/test.xml");
        parseXML("/Users/lazio14/workplace/github//LibTest/libxml2Test/libxml2Test/test.xml");
        parseMMTHTML(@"/Users/lazio14/workplace/github//LibTest/libxml2Test/libxml2Test/mmt.html");
    }
    return 0;
}
