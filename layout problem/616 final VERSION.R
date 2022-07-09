##### Part 1: Build simulation model
library(dplyr)
time_sample<-function(){
  customer_arrive_time<-0
  i<-1
  while(sum(customer_arrive_time)<300){
    if (sum(customer_arrive_time)>=0 & sum(customer_arrive_time)<60){
        customer_arrive_time[i]<-round(rnorm(1,15,3))}
    if (sum(customer_arrive_time)>=60 & sum(customer_arrive_time)<120){
        customer_arrive_time[i]<-round(rnorm(1,10,3))}
    if (sum(customer_arrive_time)>=120 & sum(customer_arrive_time)<180){
        customer_arrive_time[i]<-round(rnorm(1,5,3))}
    if (sum(customer_arrive_time)>=180 & sum(customer_arrive_time)<240){
        customer_arrive_time[i]<-round(rnorm(1,10,3))}
    if (sum(customer_arrive_time)>=240 & sum(customer_arrive_time)<300){
        customer_arrive_time[i]<-round(rnorm(1,15,3))}
    if (customer_arrive_time[i]<=0){
        customer_arrive_time<-customer_arrive_time[-i]
        i<-i-1}
  i<-i+1}

  customer_arrive_time<-head(customer_arrive_time,-1)
  return(customer_arrive_time)}

time_converse<-function(sample){
  time<-0  
  for (t in 1:length(sample)){
    time[t]<- sum(sample[1:t])}
  return(time)}

search_log1<-function(table_size,start_time){
  for (t in start_time:(start_time+30)){
    if (table_size[t]>0){
      return(t)}
  } 
  return(0)
}



###layout A
layout_A<-function(){
table_2<-0
table_2[1:400]<-table_2
table_4<-21
table_4[1:400]<-table_4
table_6<-3
table_6[1:400]<-table_6

arrive_time<-time_sample()%>%time_converse()
size<-sample(x=c(2:6),size=length(arrive_time),prob=c(0.3,0.1,0.4,0.1,0.1),replace = TRUE)
service_time<-round(runif(length(arrive_time),50,70))



get_table_time<-0
wait_time<-0
for (i in 1:length(arrive_time)){

  if (size[i]<=4){
    t<-search_log1(table_4,arrive_time[i])
    if (t!=0){
      table_4[t:(t+service_time[i])]<-table_4[t:(t+service_time[i])]-1}
  }
  if (size[i]>4&size[i]<=6){
    t<-search_log1(table_6,arrive_time[i])
    if (t!=0){
      table_6[t:(t+service_time[i])]<-table_6[t:(t+service_time[i])]-1}
  }
  get_table_time[i]<-t
  wait_time[i]<-get_table_time[i]-arrive_time[i]
}
df_A_1<-cbind(table_2,table_4,table_6)
df_A<-cbind(size,arrive_time,get_table_time,wait_time)
return(df_A)
}

###layout B
layout_B<-function(){
table_2<-4
table_2[1:400]<-table_2
table_4<-17
table_4[1:400]<-table_4
table_6<-4
table_6[1:400]<-table_6

arrive_time<-time_sample()%>%time_converse()
size<-sample(x=c(2:6),size=length(arrive_time),prob=c(0.3,0.1,0.4,0.1,0.1),replace = TRUE)
service_time<-round(runif(length(arrive_time),50,70))



get_table_time<-0
wait_time<-0
for (i in 1:length(arrive_time)){
  if (size[i]<=2){
    t<-search_log1(table_2,arrive_time[i])
    if (t!=0){
      table_2[t:(t+service_time[i])]<-table_2[t:(t+service_time[i])]-1}
  }
  if (size[i]>2&size[i]<=4){
    t<-search_log1(table_4,arrive_time[i])
    if (t!=0){
      table_4[t:(t+service_time[i])]<-table_4[t:(t+service_time[i])]-1}
  }
  if (size[i]>4&size[i]<=6){
    t<-search_log1(table_6,arrive_time[i])
    if (t!=0){
      table_6[t:(t+service_time[i])]<-table_6[t:(t+service_time[i])]-1}
  }
  get_table_time[i]<-t
  wait_time[i]<-get_table_time[i]-arrive_time[i]
}
df_B_1<-cbind(table_2,table_4,table_6)
df_B<-cbind(size,arrive_time,get_table_time,wait_time)

return(df_B)
}


##### Part 2: Comparison
lost_A<-0
lost_B<-0
for (i in 1:1000){
  result_A<-data.frame(layout_A())
  lost_A[i]<-sum(result_A$get_table_time==0)

  result_B<-data.frame(layout_B())
  lost_B[i]<-sum(result_B$get_table_time==0)
}
sum(lost_A)
sum(lost_B)

plot(table(lost_A),type = "b", frame = FALSE, pch = 19, 
     col = "red", xlab = "x", ylab = "y",main='distribution of lost groups size')
lines(table(lost_B), pch = 18, col = "blue", type = "b", lty = 2)
legend("topright", legend=c("layout A", "layout B"),
       col=c("red", "blue"), lty = 1:2, cex=0.8)

##### Part 3: Profits of the two plans
profit_per_person<-21.5
profit_A<-0
profit_B<-0
for (i in 1:1000){
simple_A<-data.frame(layout_A())
simple_A_get_service<-filter(simple_A,get_table_time!=0)
profit_A[i]<- sum(simple_A_get_service$size) * profit_per_person


simple_B<-data.frame(layout_B())
simple_B_get_service<-filter(simple_B,get_table_time!=0)
profit_B[i]<- sum(simple_B_get_service$size) * profit_per_person
}
mean(profit_A)
mean(profit_B)

