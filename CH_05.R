### 05. 데이터 분석 기초!

## 05-1. 데이터 파악하기

# 데이터를 파악할 때 사용하는 함수들
exam <- read.csv("data/csv_exam.csv")

View(exam) # 데이터 확인
dim(exam) # 몇행, 몇 열
str(exam) # 데이터 속성 확인
summary(exam)

# mpg 데이터 확인

library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터를 데이터 프레임으로 불러오기
mpg

head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
str(mpg) # 234 관측치 및 11개 변수로 구성
summary(mpg) # 요약 통계량 확인

?mpg

par(family = "AppleGothic") # 그래프에서 한글 깨짐 방지

boxplot(data = mpg, mpg$cty, main = "자동차 연비 측정",
        ylab = "연비", col = "red")

## 05-2. 변수명 바꾸기

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

library(dplyr)

df_new <- df_raw
df_new <- rename(df_new, v2 = var2)
df_new


# 혼자서 해보기
df_mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
df_mpg_new <- df_mpg

df_mpg_new
summary(df_mpg_new)
df_mpg_new <- rename(df_mpg_new, city = cty, highway = hwy)
head(df_mpg_new)

## 05-3. 파생변수 만들기

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2 # var_sum 파생변수 생성
df

df$var_mean <- (df$var1 + df$var2) / 2 # var_mean 파생변수 생성
df

str(mpg)

mpg$total <- (mpg$cty + mpg$hwy) / 2 # 통ㅎㅂ 연비 변수 생성
head(mpg)

mean(mpg$total)

# 조건문 활용 파생변수 만들기

summary(mpg$total)
hist(mpg$total)

mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 20)

table(mpg$test)

library(ggplot2)
qplot(mpg$test)

mpg$grade <- ifelse(mpg$total >= 30, "A", 
                   ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)

table(mpg$grade)
qplot(mpg$grade)

mpg$grade <- ifelse(mpg$total >= 30, "A", 
                    ifelse(mpg$total >= 25, "B", 
                           ifelse(mpg$total >= 20, "C", "D")))
table(mpg$grade)

## 분석 도전

# ggplot2 midwest 데이터를 데이터 프레임 형태로 불러오기

midwest <- as.data.frame(ggplot2::midwest)
str(midwest)

midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)
head(df_midwest)

library(dplyr)
midwest$ratio <- midwest$asian / midwest$total * 100

head(midwest)
hist(midwest$ratio)

x <- mean(midwest$ratio)

midwest$group <- ifelse(midwest$ratio >= mean(midwest$ratio), "large", "small")

head(midwest, 10)
table(midwest$group)
qplot(midwest$group)
