---
layout: page
title: Spring WebService
subtitle: WebService Setting
categories: Miscellaneous
tags: Spring
---

# Spring WebService

## web.xml 셋팅하기

```xml
  <servlet>
    <servlet-name>gPRService</servlet-name>
    <servlet-class>provider.GPRServiceEndpoint</servlet-class>
    <load-on-startup>1</load-on-startup>
  </servlet>
  <servlet-mapping>
    <servlet-name>gPRService</servlet-name>
    <url-pattern>/GPRService</url-pattern>
  </servlet-mapping>
```

## Spring Endpoint Java

```Java
package provider;

import javax.jws.WebMethod;
import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import dt.pr.GIFMMI_PRDT;
import dt.pr.IFMMI_PRHD;
import dt.pr.IFMMO_PR_RESULT;
import dt.pr.service.GPRService;

/**
 * <pre>
 * Statements
 * </pre>
 *
 * @ClassName   : GPRService.java
 * @Description : 클래스 설명을 기술합니다.
 * @author
 * @since 2017. 5. 29.
 * @version 1.0
 * @see
 * @Modification Information
 * <pre>
 *     since          author              description
 *  ===========    =============    ===========================
 *  2017. 5. 29.     xxxxxx    	최초 생성
 * </pre>
 */
@WebService(serviceName="GPRService")
public class GPRServiceEndpoint extends SpringBeanAutowiringSupport {

    @Autowired
    private GPRService gPRService;

    @WebMethod
    public IFMMO_PR_RESULT[] insert(IFMMI_PRHD prhd, GIFMMI_PRDT[] prdt) throws Exception {

        IFMMO_PR_RESULT[] res = new IFMMO_PR_RESULT[prdt.length];;

        try {

            res = gPRService.insert(prhd, prdt);

        } catch (Exception e) {

            for ( int i =0 ; i <prdt.length ; i++ ){
                res[i] = new IFMMO_PR_RESULT();
                res[i].setERROR_CODE("E");
                res[i].setERROR_MESSAGE("GPRService I/F ERROR : " + e.getMessage());
                res[i].setHOUSE_CODE(prhd.getHOUSE_CODE());
                res[i].setPR_NO(prhd.getPR_NO());
                res[i].setPR_SEQ(prdt[i].getPR_SEQ()) ;  //errdt.getPR_SEQ() );
                res[i].setIFRESULT("E");
                res[i].setIFFAILMSG("GPRService I/F ERROR : " + e.getMessage());
            }

            e.printStackTrace();

        }

        return res;
    }

}
```