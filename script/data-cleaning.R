#packagesneeded
source('script/packages.R')

survey1<- read.csv('input/survey-combined.csv')
#survey2<- read.csv('input/survey-fr.csv')

#remove whitespace (leading/trailing zero)
survey1<- survey1 %>% 
  mutate(across(where(is.character), str_trim))
survey2<- survey2 %>% 
  mutate(across(where(is.character), str_trim))

#convert all columns to characters
survey1<- survey1 %>%
          mutate(across(everything(), as.character))

survey2<- survey2 %>%
          mutate(across(everything(), as.character))

#replace blank cells with NA
survey1[survey1 == ""] <- NA 
survey2[survey2 == ""] <- NA



