package com.korea.js.serviceImpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.korea.js.dao.AcornDao;
import com.korea.js.dao.OrderDao;
import com.korea.js.dao.RestaurantDao;
import com.korea.js.dao.UserDao;
import com.korea.js.service.OrderService;
import com.korea.js.vo.Acorn;
import com.korea.js.vo.Order;
import com.korea.js.vo.Restaurant;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private RestaurantDao resDao;
	
	@Autowired
	private AcornDao acornDao;
	
	@Autowired 
	private UserDao userDao;
	
	// 메뉴 주문
	@Transactional
	@Override
	public int inserOrder(Order order) {	
		Acorn acorn = new Acorn();
		Restaurant restaurant = new Restaurant();
		
		// 레스토랑 아이디
		Long resId = order.getRestaurantId();
		// 레스토랑 정보
		Restaurant res = resDao.restaurantSalesAcorn(resId);
		// 오너 아이디
		String ownerId = res.getOwnerId();
		acorn.setFromUserId(ownerId);
		// 현재 시간 가져오기
        LocalDateTime today = LocalDateTime.now();
        // LocalDateTime을 String으로 변환
        String dt = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        // 입금날짜
        acorn.setInputDt(dt);
        // 주문금액
        Long totalAcorn = order.getTotalAcorn();
		acorn.setInputAcorn(totalAcorn);
		// 주문자 아이디
		String toUserId = order.getUserId();
		acorn.setToUserId(toUserId);
		//출금날짜
		acorn.setOutputDt(dt);
		// 출금금액
		acorn.setOutputAcorn(totalAcorn);
		// 주문금액
		restaurant.setDailySales(totalAcorn);
		// 매출 일(주문날짜)
		restaurant.setDailySalesDt(dt);
		// 레스토랑 아이디
		restaurant.setRestaurantId(resId);
		// 유저 보유 도토리
		Long userAcorn = userDao.getAcorn(toUserId);
		// 주문한 만큼 -
		Long updateAcorn = userAcorn - totalAcorn;
		
		// 주문서 저장
	    int result1 = orderDao.inserOrder(order);
	    // 도토리 리스토리 남기기
	    int result2 = acornDao.orderAcorn(acorn);
	    // 레스토랑 매출 업데이트
	    int result3 = resDao.restaurantSalesUpdate(restaurant);
	    // 남은 금액만큼 업데이트
	 	int result4 = userDao.acornCharging(toUserId, updateAcorn);
	 	// 성공여부
	 	int result = result1 * result2 * result3 * result4;
		return result;
	}
}

//#{ fromUserId }											/* param 입금자 아이디 */   
//, #{ inputDt }											/* param 입금 받은 날짜 */     
//, #{ inputAcorn }											/* param 입금 받은 도토리 */     
//, #{ toUserId }											/* param 출금자 아이디 */   
//, #{ outputDt }											/* param 출금한 날짜 */     
//, #{ outputAcorn }										/* param 출금 도토리 */

/*
	1. 주문서 저장
	2. 도토리 저장
	3. 레스토랑에 저장
	4. 유저 업데이트
*/