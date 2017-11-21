### 06. 자유자재로 데이터 가공하기

## 06-1. 데이터 전처리 - 원하는 형태로 데이터 가공하기

# dplyr은 데이터 전처리 작업에 가장 만이 사용되는 패키지
# 대표 함수
# filter(), select(), arrange(), mutate(), summarize(), group_by,
# left_join(), bind_row()

## 06-2. 조건에 맞는 데이터만 추출하기

library(dplyr)

exam <- read.csv("data/csv_exam.csv")
exam

exam %>% filter(class == 1)
exam %>% filter(class == 2)
exam %>% filter(class != 1)
exam %>% filter(class != 3)
exam %>% filter(math > 50)
exam %>% filter(math < 50)
exam %>% filter(english >= 80)
exam %>% filter(english <= 80)

# 여러조건을 충족하는 행 추출하기
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 2 & english >= 80)

# 여러조건 중 하나 이상 충족하는 행 추출하기
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(math < 90 | science < 50)

# 목록에 해당하는 행 추출하기
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1, 3, 5))

#추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)

# 혼자서 해보기 - mpg 데이터 이용 분석문제 해결
mpg <- as.data.frame(ggplot2::mpg)
summary(mpg)
head(mpg)

displ4 <- mpg %>% filter(displ <= 4)
displ5 <- mpg %>% filter(displ >= 5)

mean(displ4$hwy)
mean(displ5$hwy)

audi <- mpg %>% filter(manufacturer == "audi")
toyota <- mpg %>% filter(manufacturer == "toyota")

mean(audi$cty)
mean(toyota$cty)

car_hwy <- mpg %>% 
    filter(manufacturer %in% c("chevrolet", "ford", "honda"))

mean(car_hwy$hwy)

# Gapminder 데이터 응용
library(gapminder)
library(tidyverse)


# Sort in ascending order of lifeExp
gapminder %>% arrange(lifeExp)

# Sort in descending order of lifeExp
gapminder %>% arrange(desc(lifeExp))


# Filter for the year 1957, then arrange in descending order of population
gapminder %>% 
    filter(year == 1957) %>%
    arrange(desc(pop))
            

## 06-3. 필요한 변수만 추출하기

# 변수 추출하기
exam %>% select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)

# dplyr 함수 조합하기

exam %>% 
    filter(class == 1) %>%  # class가 1인 행 추출
    select(english)         # 영어성적 추출

# 일부만 출력하기

exam %>% 
    select(id, math) %>% 
    head

exam %>% 
    select(id, math) %>% 
    head(10)

# 혼자서 해보기 - mpg 데이터를 이용해 분석 문제를 해결

mpg_new <- mpg %>% 
    select(class, cty)

mpg_new

mpg_suv <- mpg_new %>% filter(class == "suv")

mpg_compact <- mpg_new %>% filter(class == "compact")

mean(mpg_suv$cty)
mean(mpg_compact$cty)

## 06-4. 순서대로 정렬하기

# 오름차순 정렬하기
exam %>% arrange(math)

# 내림차순 정렬하기
exam %>% arrange(desc(math))

# 여러개 변수 정렬
exam %>% arrange(class, math)

mpg
mpg_audi <- mpg %>% 
    filter(manufacturer == "audi") %>% 
    arrange(desc(hwy)) %>% 
    head(5)
mpg_audi


## 06-5. 파생변수 추가하기

# 파생변수 추가하기
exam %>% 
    mutate(total = math + english + science) %>% 
    head

# 여러 파생변수 한번에 추가
exam %>% 
    mutate(total = math + english + science,
           mean = (math + english + science)/3) %>%
    head

# mutate()에 ifelse 적용
exam %>% 
    mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
    head

# 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>% 
    mutate(total = math + science + english) %>% 
    arrange(total) %>% 
    head

# 혼자서 해보기 - mpg 데이터 분석
mpg <- as.data.frame(ggplot2::mpg)
mpg

mpg_new <- mpg

mpg_new %>% 
    mutate(fuel_eff = cty + hwy) %>% 
    head

mpg_new %>% 
    mutate(fuel_eff = cty + hwy, 
           fule_avg = fuel_eff / 2) %>% 
    head

mpg_new %>% 
    mutate(fuel_eff = cty + hwy, 
           fuel_avg = fuel_eff / 2) %>% 
    arrange(desc(fuel_avg)) %>% 
    head(3)

## 06-6. 집단별로 요약하기

# 집단별로 요약하기
exam %>% summarise(mean_math = mean(math))
exam %>% 
    group_by(class) %>%
    summarise(mean_math = mean(math))

# 여러 요약 통계량 한번에 산출하기
exam %>% 
    group_by(class) %>% 
    summarise(mean_math = mean(math),
              sum_math = sum(math),
              median_math = median(math),
              sd_math = sd(math),
              min_math = min(math),
              max_math = max(math),
              n = n())
mpg %>% 
    group_by(manufacturer, drv) %>% 
    summarise(mean_cty = mean(cty)) %>% 
    head(10)

# dplyr 조합하기

mpg %>% 
    group_by(manufacturer) %>% 
    filter(class == "suv") %>% 
    mutate(tot = cty + hwy / 2) %>%
    summarise(mean_tot = mean(tot)) %>% 
    arrange(desc(mean_tot)) %>% 
    head(5)

# 혼자서 해보기 

# Q1
mpg %>% 
    group_by(class) %>%
    summarise(mean(cty))

# Q2
mpg %>% 
    group_by(class) %>%
    summarise(mean_cty = mean(cty)) %>% 
    arrange(desc(mean_cty))

# Q3
mpg %>% 
    group_by(manufacturer) %>%
    summarise(mean_hwy = mean(hwy)) %>% 
    arrange(desc(mean_hwy)) %>% 
    head(3)

# Q4
mpg %>% 
    filter(class == "compact") %>% 
    group_by(manufacturer) %>% 
    summarise(count = n()) %>% 
    arrange(desc(count))

# Gapminder 분석

library(gapminder)
library(dplyr)

# Use mutate() to change the existing lifeExp column, by multiplying it by 12: 12 * lifeExp.
# Use mutate() to add a new column, called lifeExpMonths, calculated as 12 * lifeExp.

# Use mutate to change lifeExp to be in months
gapminder %>% mutate(lifeExp = 12 * lifeExp)

# Use mutate to create a new column called lifeExpMonths
gapminder %>% mutate(lifeExpMonths = 12 * lifeExp)


## 06-7. 데이터 합치기

# 가로로 합치기
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

test1
test2

total <- left_join(test1, test2, by = "id")
total

# 다른 데이터를 활용해 변수 추가하기

name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new

# 세로로 합치기

group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

group_b <- data.frame(id = c(6, 8, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_a
group_b

group_all <- bind_rows(group_a, group_b)
group_all

# 혼자해보기

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
head(mpg)

mpg_new <- left_join(mpg, fuel, by = "fl")
mpg_new %>% 
    select(model, fl, price_fl) %>% 
    head(5)

# 분서 도전!
# ggplot2에 들어있는 midwest 데이터를 이용한 분석

midwest <- as.data.frame(ggplot2::midwest)
str(midwest)
dim(midwest)

# Q1. 전체 인구 대비 미성년 인구 백분률 변수 추가
midwest %>% 
    mutate(ratio = (poptotal - popadults) / poptotal * 100) %>% 
    head(5)

# Q2. 미성년 인구 백분율이 가장 높은 상위 5개 country
midwest %>% 
    mutate(ratio = (poptotal - popadults) / poptotal * 100) %>% 
    arrange(desc(ratio)) %>% 
    head(5)

# Q3. 미성년 등급 변수 추가
midwest <- midwest %>% 
    mutate(ratio = (poptotal - popadults) / poptotal * 100,
           grade = ifelse(ratio >= 40, "large", 
                  ifelse(ratio >= 30, "middle", "small")))

table(midwest$grade)


# Q4. 전체 인구 대비 아이사인 인구 백분률
midwest %>% 
    mutate(ratio = popasian / poptotal * 100) %>% 
    arrange(ratio) %>% 
    select(state, county, ratio) %>% 
    head(10)
