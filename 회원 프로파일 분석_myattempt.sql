USE practice;

-- 회원 프로파일 분석용 데이터 마트
CREATE TABLE CUSTOMER_PROFILE AS
SELECT A.*,
		DATE_FORMAT(join_date, '%Y-%m') AS '가입년월',
        2021 - YEAR(birthday) + 1 AS '나이',
        CASE WHEN 2021 - YEAR(birthday) + 1 < 20 THEN '10대 이하'
			 WHEN 2021 - YEAR(birthday) + 1 < 30 THEN '20대'
             WHEN 2021 - YEAR(birthday) + 1 < 40 THEN '30대'
             WHEN 2021 - YEAR(birthday) + 1 < 50 THEN '40대'
			 ELSE '50대 이상'
             END AS '연령대',
		CASE WHEN B.mem_no IS NOT NULL THEN '구매'
			 ELSE '미구매'
             END AS '구매여부'
	FROM customer AS A
    LEFT JOIN (SELECT DISTINCT mem_no FROM SALES) AS B -- 중복 없는 회원 테이블과 판매 테이블의 결합
		ON A.mem_no = B.mem_no;
        
SELECT * FROM CUSTOMER_PROFILE;

-- 분석 보고서에 필요한 데이터 추출
-- 1. 가입년월별 회원수
SELECT 가입년월, COUNT(mem_no) FROM CUSTOMER_PROFILE GROUP BY 가입년월;

-- 2. 성별 평균 연령, 성별 및 연령대별 회원수
SELECT gender AS 성별, AVG(나이) AS 평균연령
	FROM CUSTOMER_PROFILE
		GROUP BY gender;
        
SELECT gender AS 성별, 연령대, COUNT(mem_no)
	FROM CUSTOMER_PROFILE
		GROUP BY gender, 연령대
			ORDER BY gender, 연령대;
            
-- 3. 성별 및 연령대별 회원수 + 구매여부
SELECT gender AS 성별, 연령대, 구매여부, COUNT(mem_no) AS 회원수
	FROM CUSTOMER_PROFILE
		GROUP BY gender, 연령대, 구매여부
			ORDER BY 구매여부, gender, 연령대;
