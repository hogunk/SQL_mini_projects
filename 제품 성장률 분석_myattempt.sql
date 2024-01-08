USE practice;

-- 제품 성장률 분석 데이터 마트
CREATE TABLE PRODUCT_GROWTH AS
SELECT A.mem_no,
		B.category,
        B.brand,
        A.sales_qty * B.price AS 구매금액,
        CASE WHEN DATE_FORMAT(order_date, '%Y-%m') BETWEEN '2020-01' AND '2020-03' THEN '2020년_1분기'
			 WHEN DATE_FORMAT(order_date, '%Y-%m') BETWEEN '2020-04' AND '2020-06' THEN '2020년_2분기'
             END AS 분기 -- 주문일을 1분기, 2분기로 분류
	FROM sales AS A
		LEFT JOIN product AS B
			ON A.product_code = B.product_code
            WHERE DATE_FORMAT(order_date, '%Y-%m') BETWEEN '2020-01' AND '2020-06';

SELECT * FROM PRODUCT_GROWTH; -- 데이터 마트 확인

-- 1. 카테고리별 구매금액 성장률(2020년 1분기 → 2020년 2분기)
SELECT *, 2020년_2분기_구매금액 / 2020년_1분기_구매금액 - 1 AS 성장률
	FROM(
		 SELECT category,
				SUM(CASE WHEN 분기 = '2020년_1분기' THEN 구매금액 END) AS 2020년_1분기_구매금액,
                SUM(CASE WHEN 분기 = '2020년_2분기' THEN 구매금액 END) AS 2020년_2분기_구매금액
			FROM PRODUCT_GROWTH -- 분기별 구매금액을 도출, 성장률을 계산
			GROUP BY category) AS A
		ORDER BY 성장률 DESC;
        
-- 2. beauty 카테고리 중 브랜드별 구매지표
SELECT brand,
	   COUNT(DISTINCT mem_no) AS 구매자수, -- 브랜드별 구매자수
       SUM(구매금액) AS 구매금액_합계, -- 브랜드별 금액 합
       SUM(구매금액) / COUNT(DISTINCT mem_no) AS 인당_구매금액
	FROM PRODUCT_GROWTH
    WHERE category = 'beauty'
	GROUP BY brand
	ORDER BY 4 DESC;