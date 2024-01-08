USE practice;

-- 재구매율 및 구매주기 분석용 데이터 마트
CREATE TABLE RE_PURCHASE_CYCLE AS
SELECT *,
		CASE WHEN DATE_ADD(최초구매일자, INTERVAL +1 DAY) <= 최근구매일자 THEN 'Y'
        ELSE 'N'
			END AS 재구매여부, -- 최초 구매 후 +1일 후 구매하면 재구매자로 여김
		DATEDIFF(최근구매일자, 최초구매일자) AS 구매간격, -- 구매간격 계산
        CASE WHEN 구매횟수 - 1 = 0 OR DATEDIFF(최근구매일자, 최초구매일자) = 0 THEN 0 -- 구매주기에서 분모나 분자가 0인 경우 0 반환
        ELSE DATEDIFF(최근구매일자, 최초구매일자) / (구매횟수 - 1) -- 구매주기 계산식
			END AS 구매주기
	FROM
		(SELECT mem_no,
				MIN(order_date) AS 최초구매일자,
				MAX(order_date) AS 최근구매일자,
				COUNT(order_no) AS 구매횟수
			FROM sales
			WHERE mem_no <> '9999999' -- 번호가 9999999인 비회원은 제외
			GROUP BY mem_no) AS A;

SELECT * FROM RE_PURCHASE_CYCLE; -- 테이블 확인

-- 1. 재구매 회원수 비중
SELECT COUNT(DISTINCT mem_no) AS 구매회원수,
		COUNT(DISTINCT CASE WHEN 재구매여부 = 'Y' THEN mem_no END) AS 재구매회원수
	FROM RE_PURCHASE_CYCLE;
    
-- 2. 평균 구매주기 및 구매주기 구간별 회원수
SELECT AVG(구매주기) FROM RE_PURCHASE_CYCLE WHERE 구매주기 > 0; -- 구매주기 0 이상인 경우만 평균 추출 가능

-- 구매주기 구간을 7일 배수로 나누고 구간별 회원수를 확인
SELECT 구매주기_구간, COUNT(mem_no) AS 회원수
	FROM( 
		SELECT *,
				CASE WHEN 구매주기 <= 7 THEN '7일 이내'
				WHEN 구매주기 <= 14 THEN '14일 이내'
				WHEN 구매주기 <= 21 THEN '21일 이내'
				WHEN 구매주기 <= 28 THEN '28일 이내'
				ELSE '29일 이후'
				END AS 구매주기_구간
			FROM RE_PURCHASE_CYCLE WHERE 구매주기 > 0) AS A -- 구매주기 0 이상
		GROUP BY 구매주기_구간;