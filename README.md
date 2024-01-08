SQL analysis projects under SQL for elementary data analysis course available on Boostcourse.

부스트코스에 열려 있는 '기초 데이터 분석을 위한 핵심 SQL'의 SQL 데이터 분석 프로젝트 모음입니다.
각 부분별 엑셀파일 형태의 분석보고서가 결과물로 있습니다.
모든 분석은 제공되는 Customer, Product, Sales 파일로 이루어진 practice 데이터베이스를 활용해서 진행됩니다.

1. 회원 프로파일 분석
- 주어진 practice 데이터베이스를 이용해서 회원 프로파일 분석용 데이터 마트를 생성
- 회원 정보에서 나이 및 연령대, 구매 여부를 추출하여 분석 보고서 작성에 활용
- 가입연월별 회원수, 성별 평균 연령과 성별 및 연령대별 회원수, 그리고 성별 및 연령대별 회원수 + 구매여부를 시각화
- 회원가입수의 추세, 성별 평균 연령 차이, 성별 및 연령대별 회원수 분포, 가입 후 구매 전환 여부에 대한 분석이 가능
- **2019년 10월에 가장 많은 회원이 가입했고, 30대 여성 회원이 가장 많으며, 가입 후 구매 전환이 안된 회원도 30대 여성에 가장 많이 분포함**

2. RFM 분석
- Recency(최근성), Frequency(빈도), Monetary(금액) 분석을 위해 회원의 세분화가 필요함
- 2020년부터를 최근으로 치부하여 회원별 총 구매 금액과 구매 빈도 정보를 추출
- 구매 금액과 빈도를 기준으로 VIP, 우수회원, 일반회원, 잠재회원으로 세분화하고, 세분화별 매출액, 세분화별 인당 구매금액을 시각화
- 세분화별 회원 분포 및 매출 비중 분석이 가능
- **VIP 회원의 비중이 가장 큼**

3. 재구매율 및 구매주기 분석
- 재구매자: 최초 구매일 이후, +1일 후 구매자
- 구매주기 = 구매간격(최근구매일자 - 최초구매일자) / (구매횟수 - 1)
  - 구매횟수에서 1을 빼는 이유는 첫 방문 이후 몇 번 방문했는지가 주기를 결정하기 때문
- 구매 회원중 재구매 회원수 비중을 계산
- 구매주기를 ~7일, ~14일, ~21일, ~28일, 29일~ 로 나누고 각 구간별 회원수 도출 및 시각화
- 평균 구매주기와 구간별 회원수 분포 분석 가능
- **평균 구매주기는 5.29일이며, ~7일 구간에 가장 많은 회원이 분포함**

4. 제품 성장률 분석
- 제품 주문일을 2020년 1분기와 2020년 2분기로 분류하여 제품 카테고리별 성장률을 확인
- 성장률 = (2020년 2분기 구매금액) / (2020년 1분기 구매금액) - 1
- 구매금액 성장률이 가장 높은 카테고리는 beauty이며, beauty 카테고리 내 브랜드별 구매지표를 시각화
- **chanel 브랜드의 구매지표가 가장 높고, 성장률에 가장 큰 영향을 미치는 것을 확인**
