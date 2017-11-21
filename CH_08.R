### 08. 그래프 만들기

## 08-1. R로 만들 수 있는 그래프 살펴보기

## 08-2. 산점도 - 변수 간 관계 표현하기

library(ggplot2)

# 배경 설정하기
# x축은 displ, y측은 hwy로 지정해 배경 생성

ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 삼점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
    geom_point()

# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    xlim(3, 6)

# x축 범위 3~6, y축 범위 10~30 으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    xlim(3, 6) + 
    ylim(10, 30)

# 혼자서 해보기
# Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비)간의 관계 확인
library(plotly)

g <- ggplot(data = mpg, aes(x = cty, y = hwy)) +
    geom_point()
ggplotly(g)

# Q2. midwest 데이터를 이용해 전체 인구와 아시안 인구 간에 관계 확인
# x: poptotal, y: popasian, 전체: 50만명 이하, 아시안: 1만명 이하 지역

g <- ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
    geom_point() +
    xlim(0, 500000) + 
    ylim(0, 10000)
g
ggplotly(g)

## 08-3. 막대 그래프 - 집단 간 차이 표현하기

## 평균 막대 그래프 만들기 

# mpg, 구동방식별 평균 고속도록 연비 그래프
library(dplyr)

mpg <-as.data.frame(ggplot2::mpg)

df_mpg <- mpg %>% 
    group_by(drv) %>% 
    summarise(mean_hwy = mean(hwy))

df_mpg

# 그래프 생성하기 : geom_col
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) +
    geom_col()

# 크기 순으로 정렬하기 : reorder
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), 
                          y = mean_hwy)) + geom_col()

# 빈도 막대 그래프 그리기 (y축 없이 x축만 지정)
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()
ggplot(data = mpg, aes(x = cty)) + geom_bar()

# 혼자서 해보기
# Q1. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 확인.
#     도시 연비가 높은 회사 다섯 곳을 연비 높은 순으로 막대 그래프로 표현.
table(mpg$class)
df_mpg <- mpg %>% 
    filter(class == "suv") %>% 
    group_by(manufacturer) %>% 
    summarise(mean_cty = mean(cty)) %>% 
    arrange(desc(mean_cty)) %>% 
    head(5)
df_mpg

ggplot(data = df_mpg, aes(x = reorder(manufacturer, -mean_cty), 
                          y = mean_cty)) + geom_col()

# Q2. 자동차 중에서 어떤 class가 가장 많은지 비교. 자동차 종류별 빈도
ggplot(data = mpg, aes(x = class)) + geom_bar()


## 08-3. 선 그래프 - 시간에 따라 달라지는 데이터 표현하기
# 시계열 그래프 만들기

ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 혼자서 해보기
# Q1. 시간에 따른 개인별 저축률의 변화를 시계열 그래프로...

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()


## 08-5. 상자 그림 - 집단 간 분포 차이 표현하기

library(plotly)

# 상자 그림 만들기
g <- ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
ggplotly(g)

# 혼자 해보기
# Q1. 세 차장의 도시 연비가 어떻게 다른가
df_mpg <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = df_mpg, aes(x = class, y = cty)) + geom_boxplot()
