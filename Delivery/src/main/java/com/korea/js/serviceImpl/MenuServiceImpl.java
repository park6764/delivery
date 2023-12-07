package com.korea.js.serviceImpl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.korea.js.dao.MenuDao;
import com.korea.js.service.MenuService;
import com.korea.js.vo.Menu;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class MenuServiceImpl implements MenuService {
	@Autowired
	private MenuDao	menuDao;
	
	@Override
	public int addMenu(Menu menu, HttpServletRequest request) {
//		Long restaurantId = menu.getRestaurantId();
//		String menuName = menu.getMenuName();
//		int menuPrice = menu.getMenuPrice();
//		String menuExplanation = menu.getMenuExplanation();
		String role = menu.getRole();
		
		// 세션의 서블릿 컨텍스트를 기반으로 "/img/" 디렉토리의 실제 경로를 가져옴
		String path = request.getSession().getServletContext().getRealPath("/img/");
		System.out.println("path: " + path);

		if(!role.equals("오너")) { return 0; } // 관리자가 아니면 레스토랑 추가 불가
		
		//HttpServletRequest를 통해 파일을 가져온다
		MultipartFile fileUpload = menu.getMenuImg();
		

		// 파일이 null이거나 비어있으면 추가 실패
//		if (fileUpload == null || fileUpload.isEmpty()) {
//			return 0;
//		}

		String originalFilename = fileUpload.getOriginalFilename();
		
		// 중복 파일명 처리
		File f = new File(path + originalFilename);
//		if(f.exists()) {
//			return 0;
//		}
		
		try {
			// 파일 저장
			fileUpload.transferTo(f);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		menu.setMenuImgName(originalFilename);
		int result = menuDao.addMenu(menu);
		return result;
	}

	@Override
	public List<Menu> menus(Long restaurantId) {
		List<Menu> result = menuDao.menus(restaurantId);
		return result;
	}

}
