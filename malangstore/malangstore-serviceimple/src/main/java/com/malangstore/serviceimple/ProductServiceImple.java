package com.malangstore.serviceimple;

import com.malangstore.beans.Category;
import com.malangstore.beans.Product;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

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

	private HashMap<String, String> fileList = new HashMap<String, String>();

    @Override
    public HashMap<String, Object> productList(HashMap<String, Object> map) {

        HashMap<String, Object> resultMap = productDao.productList(Integer.valueOf(String.valueOf(map.get("subcategory_no"))), Integer.valueOf(String.valueOf(map.get("page"))));
        int count = productDao.productListCount(Integer.valueOf(String.valueOf(map.get("subcategory_no"))));

        resultMap.put("productListCount", count);

        return resultMap;
    }

	@Override
	public HashMap<String, Object> registProduct(List<MultipartFile> images, HashMap<String, Object> map) {

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

			success = productDao.registProduct(map, imageLen);

		} catch (IOException e) {
			e.printStackTrace();
		}

		resultMap.put("success", success);

    	return resultMap;
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
