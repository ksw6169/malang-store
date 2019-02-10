package com.malangstore.serviceimple;

import com.malangstore.beans.Photo;
import com.malangstore.beans.Product;
import com.malangstore.dao.CategoryDao;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

    @Autowired
	CategoryDao categoryDao;

	private HashMap<String, String> fileList = new HashMap<String, String>();


	/**
	 *  상품 리스트 가져오기
	 */
    @Override
    public HashMap<String, Object> productList(HashMap<String, Object> map) {

    	int subCategoryNo = Integer.valueOf(String.valueOf(map.get("subcategory_no")));
		int pageNo = Integer.valueOf(String.valueOf(map.get("page")));

		List<Product> productList = productDao.productList(subCategoryNo, pageNo);
	    int count = productDao.productListCount(subCategoryNo);
	    List<Photo> photoList = productDao.getPhoto(productList);
	    String subCategoryName = categoryDao.getCategoryName(subCategoryNo);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("productList", productList);
	    resultMap.put("productListCount", count);
	    resultMap.put("photoList", photoList);
	    resultMap.put("subCategoryName", subCategoryName);

        return resultMap;
    }


	/**
	 *  상품 등록
	 */
	@Override
	public HashMap<String, Object> newProduct(List<MultipartFile> images, HashMap<String, Object> map) {

    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	int success = 0;

		try {
			Resource resource = new ClassPathResource("META-INF/resources/img/");
			String savePath = resource.getFile().getAbsolutePath();
			savePath = savePath.replace("target\\classes", "src\\main\\resources");

			// 폴더가 없을 경우 폴더 생성
			File dir = new File(savePath);
			if(!dir.exists()) {
				System.out.println("폴더 없음 - 폴더 생성");
				dir.mkdir();
			}

			int imageLen = 0;
			long sizeSum = 0;

			for(MultipartFile image : images) {
				String originalFileName = image.getOriginalFilename();	// 파일명 추출

				// 파일명 확장자 검사
				/*if(!isValidExtension(originalFileName)) {

				}*/

				// 파일 용량 검사
				/*sizeSum += image.getSize();
				if(sizeSum >= 10*1024*1024) {   // 10MB가 넘을 경우

				}*/

				String newFileName = System.currentTimeMillis()+originalFileName.substring(originalFileName.lastIndexOf("."));	// 새 파일명 추출

				imageLen++;

				// 파일 추출
				byte[] bytes = image.getBytes();									// MultipartFile에서 바이트 추출
				Path filePath = Paths.get(savePath+"/"+newFileName);			// 파일 생성 경로 추출
				Files.write(filePath,  bytes);										// 새 경로에 해당 파일 생성
				fileList.put(newFileName, originalFileName);						// 새 경로, 원 경로 담음
				map.put("photo_name"+imageLen, newFileName);
			}

			resultMap = productDao.newProduct(map, imageLen);

		} catch (IOException e) {
			e.printStackTrace();
		}

    	return resultMap;
	}


	/**
	 *  상품 정보 가져오기(1개)
	 */
	@Override
	public HashMap<String, Object> productDetail(HashMap<String, Object> map) {

    	int product_no = Integer.valueOf(String.valueOf(map.get("product_no")));

    	Product product = productDao.productDetail(product_no);

    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("product", product);

    	List<Photo> photolist = productDao.getPhotoList(product_no);
		resultMap.put("photoList", photolist);

    	return resultMap;
	}


	/**
	 *  파일 확장자 검사
	 */
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
