## 데이터 프레임 만들기
english <- c(90, 80, 60, 70)
english

math <- c(50,60, 100, 20)
math

df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

df_midterm <- data.frame(english = c(90, 80, 60, 70), 
                        math = c(50,60, 100, 20), 
                        class = c(1, 1, 2, 2))
df_midterm

df_fruit_sales <- data.frame(price = c(1800, 1500, 3000), 
                             sales = c(24, 38, 13))
df_fruit_sales

mean(df_fruit_sales$price)
mean(df_fruit_sales$sales)

## 외부 데이터 불러오기 (Excel)

library(readxl)
df_exam <- read_excel("data/excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$math)

df_exam_novar <- read_excel("data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

df_exam_sheet <- read_excel("data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

## 외부 데이터 불러오기 (CSV)

df_csv_exam <- read.csv("data/csv_exam.csv", stringsAsFactors = F)
df_csv_exam

## 데이터 프레임을 CSV 파일로 저장하기

df_midterm <- data.frame(english = c(90, 80, 60, 70), 
                         math = c(50,60, 100, 20), 
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")

# RData 파일 저장

save(df_midterm, file = "df_midterm.rda")

rm(df_midterm) # df_midterm 삭제
load("df_midterm.rda") # Rda 파일 불러오기
df_midterm


# 엑셀 파일 불러와 df_eaxm에 할당하기
df_exam <- read_excel("data/excel_exam.xlsx")

# csv 파일 불러와 df_csv_exam에 할당하기
df_csv_exam <- read.csv("data/csv_exam.csv")


