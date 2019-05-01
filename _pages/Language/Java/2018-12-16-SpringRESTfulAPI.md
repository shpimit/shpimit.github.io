---
layout: page
title: Spring RESTful API
subtitle: RESTful API Setting
categories: Miscellaneous
tags: Spring
---

# Spring RESTful API

```Java
package dt.pr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import common.rest.RestErrorResponse;
import common.rest.RestException;
import dt.pr.service.PRService;
import dt.pr.vo.PRProceedingVO;

import able.com.web.HController;

/**
 * <pre>
 * Statements
 * </pre>
 *
 * @ClassName   : PRServiceRestController.java
 * @Description : 클래스 설명을 기술합니다.
 * @author xxxxx
 * @since 2018. 7. 31.
 * @version 1.0
 * @see
 * @Modification Information
 * <pre>
 *     since          author              description
 *  ===========    =============    ===========================
 *  2018. 7. 31.     xxxxx        최초 생성
 * </pre>
 */*

@RestController
public class PRServiceRestController extends HController {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "prService")
	private PRService prService;


    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/GPRO/prproceeding", method = RequestMethod.POST)
    public ResponseEntity<PRProceedingVO> selectPRProceedings (RequestEntity<String> requestEntity) throws Exception {

        logger.debug("request body : " + requestEntity.getBody());
        HttpHeaders headers = requestEntity.getHeaders();
        logger.debug("request headers : " + headers);
        HttpMethod method = requestEntity.getMethod();
        logger.debug("request method : " + method);
        logger.debug("request url: " + requestEntity.getUrl());

        ResponseEntity<PRProceedingVO> responseEntity = null;

        try{

            Gson gson = new Gson();
            String json = requestEntity.getBody();
            Map<String,Object> param = new HashMap<String,Object>();
            param = (Map<String,Object>) gson.fromJson(json, param.getClass());

            PRProceedingVO prProceeding = prService.selectPRProceedings(param);

            System.out.println("PRServiceRestController.selectPRProceedings()========"+ prProceeding.toString());

            if(prProceeding == null){
                // 해당 값이 없을때 NOT_FOUND
//                responseEntity = new ResponseEntity<PRProceedingVO>(prProceeding, HttpStatus.NOT_FOUND);
                throw new RestException("NOT_FOUND");
            }else{
                responseEntity = new ResponseEntity<PRProceedingVO>(prProceeding, HttpStatus.OK);
            }

        }catch(Exception e){
            //RestException 을 별도로 사용할 경우에 사용하며
            //exception 처리는 공통으로 처리해야 함
            throw new RestException(e.getMessage());
        }

        return responseEntity;
    }

//	@RequestMapping(value = "/GPRO/selectItem1111/{itemno}", method = RequestMethod.GET)
//    public ResponseEntity<BasicSampleVO> selectItem (@PathVariable("itemno") String itemno) throws Exception {
//
//	    System.out.println("PRServiceRestController.selectItem()");
//        System.out.println("PRServiceRestController.selectItem()");
//        System.out.println("PRServiceRestController.selectItem()");
//        System.out.println("PRServiceRestController.selectItem()");
//        System.out.println("PRServiceRestController.selectItem()");
//
//	    ResponseEntity<BasicSampleVO> responseEntity = null;
//
//
//	    try{
//            //파라메터 id에 대한 시큐어 처리는 별도로 해줘야 한다.
//            BasicSampleVO sample = prService.selectSample(itemno);
//
//            if(sample==null){
//                // 해당 값이 없을때 NOT_FOUND
//                responseEntity = new ResponseEntity<BasicSampleVO>(sample, HttpStatus.NOT_FOUND);
//            }else{
//                responseEntity = new ResponseEntity<BasicSampleVO>(sample, HttpStatus.OK);
//            }
//
//	    }catch(Exception e){
//	        throw new RestException(e.getMessage());
//	    }
//        return responseEntity;
//    }


	//아래코드는 controller 별로 별도 exception 처리가 필요할 경우 사용함
    @ExceptionHandler(Exception.class)
    public ResponseEntity<RestErrorResponse> exceptionHandler(Exception ex){
        RestErrorResponse error = new RestErrorResponse();
        error.setErrorCode(HttpStatus.PRECONDITION_FAILED.value());
        error.setMessage("에러가 발생했습니다.");

        return new ResponseEntity<RestErrorResponse>(error, HttpStatus.OK);
    }


	//아래는 RequestEntity header, url 등 정보 조회시 참조 소스
	/*@RequestMapping(value = "/rst/something", method = RequestMethod.PUT)
	public void handle(@RequestBody String body, Writer writer) throws IOException {
	  writer.write(body);
	}*/
	/*@RequestMapping(value = "/rst/selectItemList", method = RequestMethod.GET)
    public ResponseEntity<List<BasicSampleVO>> selectItemList (RequestEntity<String> requestEntity) throws Exception {
        System.out.println("request body : " + requestEntity.getBody());
        HttpHeaders headers = requestEntity.getHeaders();
        System.out.println("request headers : " + headers);
        HttpMethod method = requestEntity.getMethod();
        System.out.println("request method : " + method);
        System.out.println("request url: " + requestEntity.getUrl());

        List<BasicSampleVO> sampleList = basicSampleService.selectSampleList(null);

        ResponseEntity<List<BasicSampleVO>> responseEntity =
                new ResponseEntity<List<BasicSampleVO>>(sampleList, HttpStatus.OK);
        return responseEntity;
    }*/
}

```