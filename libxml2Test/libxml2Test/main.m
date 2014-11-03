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

void parseHTML()
{
    xmlDocPtr doc = xmlParseFile("/Users/lazio14/Desktop/test.xml");
    
    xmlXPathContextPtr context = xmlXPathNewContext(doc); //获取context指针
    xmlXPathObjectPtr result = xmlXPathEvalExpression((xmlChar*)("/root/node"), context); //根据条件xpath以及context来进行查询，条件格式：xmlChar *szXpath =(xmlChar *) ("/root/node2[@attribute='yes']");
    
    if(xmlXPathNodeSetIsEmpty(result->nodesetval)) //判断查询后的结果是否为空
    {
        NSLog(@"result is empty");
    }
    else
    {
        xmlNodeSetPtr nodeset = result->nodesetval; //这个结点集对象包含在集合中的元素数目(nodeNr)及一个结点数组(nodeTab)。
        for (int i=0; i < nodeset->nodeNr; i++) //遍历结果结点集合
        {
            xmlChar* keyword = xmlNodeListGetString(doc, nodeset->nodeTab[i]->xmlChildrenNode, 1);
            NSLog(@"%s", keyword);
        }
    }
    xmlXPathFreeObject (result); //释放内存
    xmlCleanupParser();//清除由libxml2申请的内存
    xmlFreeDoc(doc);
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
