USE practice;

-- RFM(Recency, Frequency, Monetary) 분석용 데이터 마트
CREATE TABLE RFM AS
    SELECT A.*,
			B.구매금액,
            B.구매횟수
		FROM customer AS A
        LEFT JOIN
		(SELECT A.mem_no,
				SUM(A.sales_qty * B.price) AS 구매금액, -- Monetary: 구매금액
				COUNT(A.order_no) AS 구매횟수 -- Frequency: 구매빈도
			FROM sales as A
			LEFT JOIN product AS B
				ON A.product_code = B.product_code
					WHERE YEAR(A.order_date) = '2020' -- Recency: 최근성(2020년을 최근으로 치부, 기록 조회)
			GROUP BY A.mem_no) AS B
		ON A.mem_no = B.mem_no;

SELECT * FROM RFM; -- RFM테이블 확인. 가입만 하고 구매 기록이 없는 회원 다수 존재

-- 1. RFM 세분화별 회원수
SELECT *,
		CASE WHEN 구매금액 > 5000000 THEN 'VIP' -- 5백만원 이상 구매 시 VIP
			 WHEN 구매금액 > 1000000 OR 구매횟수 > 3 THEN '우수회원' -- 구매금액 백만원 이상, 혹은 3번 이상 구매시 우수회원
             WHEN 구매금액 > 0 THEN '일반회원' -- 구매금액 0원 이상은 일반회원
             ELSE '잠재회원' -- 나머지는 잠재회원
             END AS 회원세분화
FROM RFM;

SELECT 회원세분화, COUNT(mem_no) AS 회원수
	FROM
		(SELECT *,
				CASE WHEN 구매금액 > 5000000 THEN 'VIP' -- 5백만원 이상 구매 시 VIP
					 WHEN 구매금액 > 1000000 OR 구매횟수 > 3 THEN '우수회원' -- 구매금액 백만원 이상, 혹은 3번 이상 구매시 우수회원
					 WHEN 구매금액 > 0 THEN '일반회원' -- 구매금액 0원 이상은 일반회원
					 ELSE '잠재회원' -- 나머지는 잠재회원
					 END AS 회원세분화
		FROM RFM) AS A
        GROUP BY 회원세분화 -- 위 테이블에서 회원등급별 회원수를 추출
        ORDER BY 회원수;

-- 2. RFM 세분화별 매출액
-- 위와 동일한 코드에서 조회할 내용만 변경
SELECT 회원세분화, SUM(구매금액) AS 구매금액
	FROM
		(SELECT *,
				CASE WHEN 구매금액 > 5000000 THEN 'VIP' -- 5백만원 이상 구매 시 VIP
					 WHEN 구매금액 > 1000000 OR 구매횟수 > 3 THEN '우수회원' -- 구매금액 백만원 이상, 혹은 3번 이상 구매시 우수회원
					 WHEN 구매금액 > 0 THEN '일반회원' -- 구매금액 0원 이상은 일반회원
					 ELSE '잠재회원' -- 나머지는 잠재회원
					 END AS 회원세분화
		FROM RFM) AS A
        GROUP BY 회원세분화
        ORDER BY 구매금액 DESC;
        
-- 3. RFM 세분화별 인당 구매금액
-- 위와 동일한 코드에서 조회할 내용만 변경
SELECT 회원세분화, SUM(구매금액) / COUNT(mem_no) AS 인당_구매금액
	FROM
		(SELECT *,
				CASE WHEN 구매금액 > 5000000 THEN 'VIP' -- 5백만원 이상 구매 시 VIP
					 WHEN 구매금액 > 1000000 OR 구매횟수 > 3 THEN '우수회원' -- 구매금액 백만원 이상, 혹은 3번 이상 구매시 우수회원
					 WHEN 구매금액 > 0 THEN '일반회원' -- 구매금액 0원 이상은 일반회원
					 ELSE '잠재회원' -- 나머지는 잠재회원
					 END AS 회원세분화
		FROM RFM) AS A
        GROUP BY 회원세분화
        ORDER BY 인당_구매금액 DESC;