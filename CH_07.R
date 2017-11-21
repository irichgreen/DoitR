### 07. 데이터 정제 - 빠진 데이터, 이상한 데이터 제거하기

# 결측치 찾기
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df
is.na(df)
table(is.na(df))    #결측치 빈도 출력
table(is.na(df$sex))
table(is.na(df$score))

mean(df$score)

# 결측치 제거하기

library(tidyverse)

df %>% filter(is.na(score))
df %>% filter(is.na(sex))

df %>% filter(!is.na(score))
df %>% filter(!is.na(sex))

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

# 결측치가 하나라도 있으면 제거하기

df_nomiss2 <- na.omit(df)
df_nomiss2

# 함수의 결측치 제외 기능 이용하기

mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam <- read.csv("data/csv_exam.csv")
exam[c(3, 8, 15), "math"] <- NA
exam

exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))

exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

# 평균값으로 결측치 대체하기

mean(exam$math, na.rm = T)

exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

mean(exam$math)

# 혼자서 해보기

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

is.na(mpg$hwy)
table(is.na(mpg$hwy))
table(is.na(mpg$drv))

mpg_new <- mpg %>% 
    filter(!is.na(hwy)) %>% 
    group_by(drv) %>% 
    summarise(mean_hwy <- mean(hwy))

mpg_new


## 07-2. 이상한 데이터를 찾아라! - 이상치 정제하기

# 이상치 제거하기 - 존재할 수 없는 값

outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier

table(outlier$sex)
table(outlier$score)

outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
    filter(!is.na(sex) & !is.na(score)) %>% 
    group_by(sex) %>% 
    summarise(mean_score = mean(score))

# 이상치 제거하기 - 극단적인 값

boxplot(mpg$hwy)
boxplot(mpg$hwy)$stat

# 결측 처리하기
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외 및 분석
mpg %>% 
    group_by(drv) %>% 
    summarise(mean_hwy = mean(hwy, na.rm = T))

# 혼자서 해보기

mpg <- as.data.frame(ggplot2::mpg)
mpg
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

# Q1. drv 이상치 확인하기

table(mpg$drv) # 이상치 확인
# 4   f   k   r 
# 100 106   4  24 
# drv가 4, f, r이면 기존 값 유지, 그 외 NA 할당
mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)

# Q2-1. 박스 플롯을 이용해 cty에 이상치가 있는지 확인
boxplot(mpg$cty)$stats

# Q2-2. 박스 플롯의 통계치를 이용해 정삼 범위를 벗어난 값 결측 처리
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)

# Q2-3. Boxplot으로 다시 확인
boxplot(mpg$cty)

# library(dplyr)
# Q3. 이상치를 제외한 다음 drv별로 cty 평균이 어떻게 다른지 확인
mpg %>% 
    filter(!is.na(drv) & !is.na(cty)) %>% 
    group_by(drv) %>% 
    summarise(cty_mean = mean(cty))

