package com.malangstore.serviceimple;

import com.malangstore.beans.Category;
import com.malangstore.beans.Product;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;

@Service("productService")
public class ProductServiceImple implements ProductService {

    @Autowired
    ProductDao productDao;

    @Override
    public HashMap<String, Object> productList(HashMap<String, Object> map) {

        List<Product> list = productDao.productList(Integer.valueOf(String.valueOf(map.get("subcategory_no"))), Integer.valueOf(String.valueOf(map.get("page"))));
        int count = productDao.productListCount(Integer.valueOf(String.valueOf(map.get("subcategory_no"))));

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("productList", list);
        resultMap.put("productListCount", count);

        return resultMap;
    }

	@Override
	public HashMap<String, Object> registProduct(String root, List<MultipartFile> images, HashMap<String, Object> map) {

		System.out.println("service / product_name : "+map.get("product_name"));
		System.out.println("service / product_detail : "+map.get("product_detail"));
		System.out.println("service / subcategory_no : "+map.get("subcategory_no"));

    	long sizeSum = 0;
		for(MultipartFile image : images) {
			String originalFileName = image.getOriginalFilename();

			System.out.println("service / fileName: "+originalFileName);

			// 1. 확장자 검사
			/*if(!isValidExtension(originalFileName)) {

			}*/

			// 2. 용량 검사
			/*sizeSum += image.getSize();
			if(sizeSum >= 10*1024*1024) {   // 10MB가 넘을 경우

			}*/
		}

    	return null;
	}


	private boolean isValidExtension(String originalFileName) {
		String originalFileNameExtension = originalFileName.substring(originalFileName.lastIndexOf(".")+1);

		switch (originalFileNameExtension) {
			case "jpg":
			case "png":
			case "gif":
				return true;
		}

		return false;
	}
}
