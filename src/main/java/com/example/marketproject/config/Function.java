package com.example.marketproject.config;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Function {
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

	public static String readBody(HttpServletRequest request) throws IOException {
		BufferedReader input = new BufferedReader(new InputStreamReader(request.getInputStream()));
		StringBuilder builder = new StringBuilder();
		String buffer;
		while ((buffer = input.readLine()) != null) {
			if (builder.length() > 0) {
				builder.append("\n");
			}
			builder.append(buffer);
		}
		return builder.toString();
	}

	public static Long createOrderNo (Date now) {
		String str = sdf.format(now) + String.format("%03d", (int)((Math.random() * 999) + 1)); 
	
		return Long.parseLong(str);
	}
	
	public static final Map<String, String> orderStateCode = new HashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("rc", "주문접수");			// Receipt
			put("dp", "입금확인");			// Deposit
			put("sh", "배송중");			// Shipping
			put("dc", "배송완료");			// Delivery Completed
			put("pc", "구매확정");			// Purchase Confirmation
			put("rt", "반품");			// Return
			put("ex", "교환");			// Exchange
			put("cc", "환불");			// Cancel
		}
	};
	
	/*public static int productCrolling() {
		ProductRepository productRepository = new ProductRepository();
		ProductVO productVO;
		
		// 크롤링 주소지정
		// 스타일난다 베스트 카테고리 상품 크롤링
		String url = "https://stylenanda.com/product/list.html?cate_no=3540";
		int totalCount = 0;
		int sucessCount = 0;
		
		int defaultStock = 30;
		
		
		System.out.println("=====================================");
		System.out.println("상품 초기화(크롤링 등록) 시작");
		System.out.println("=====================================");
		
		// 크롤링의 페이지의 데이터를 Document에 저장
		try {
			int deleteResult = productRepository.deleteByQuery("truncate table product");
			Document doc = Jsoup.connect(url).get();
			//System.out.println(doc);
			Iterator<Element> iter = doc.select("ul.column4 > li div.inner-box").iterator();
			
			while (iter.hasNext()) {
				productVO = new ProductVO();
				String productName = iter.next().select("div.name > a").text().replace("상품명 : ", "").replaceAll("[ ]#.*", "");
				int price = Integer.parseInt(iter.next().select("div.table > div.price_wrap > span.price").text().replaceAll("[^0-9]","")); // 판매가
				
				productVO.setProductName(productName);
				productVO.setPrice(price);
				productVO.setStock(defaultStock);
				
				int result = productRepository.save(productVO);
				if (result > 0) {
					System.out.printf("상품 등록 성공 : %s(판매가 : %d원, 수량 :  %d)\n", productName, price, defaultStock);
					sucessCount++;
				}
				else {
					System.out.printf("상품 등록 실패 : %s(판매가 : %d원, 수량 :  %d)\n", productName, price, defaultStock);
				}
					
				totalCount++;
			}
			System.out.println("=====================================");
			System.out.println(
				String.format("크롤링 완료 정보\n총 건수 : %d\n성공 건수 : %d\n실패 건수 : %d",
					totalCount, sucessCount, totalCount - sucessCount
				)
			);
			System.out.println("=====================================");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}*/
	
}
