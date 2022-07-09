install.packages('devtools')
library(devtools)
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS=TRUE)
devtools::install_github('WXCode/AD616', force = TRUE)
3

library(AD616)
DT=Tree$new(name='bp_sp',type = 'decision')
DT$addChance(pNode = 'bp_sp',name = 'Battle Pacific', cost = 0,route = 'OPTION A')
DT$addTerminal(pNode = 'Battle Pacific',prob = 0.2,name = 'HIGH DEMAND',payoff = 1200)
DT$addTerminal(pNode = 'Battle Pacific',prob = 0.5,name = 'MED DEMAND',payoff = 700)
DT$addTerminal(pNode = 'Battle Pacific',prob = 0.3,name = 'LOW DEMAND',payoff = 300)




DT$addChance(pNode = 'bp_sp',name = 'Space Pirates', cost = 0,route = 'OPTION B')
DT$addChance(pNode = 'Space Pirates',name = 'WITH COMPETITOR', cost = 0,prob = 0.6)
DT$addTerminal(pNode = 'WITH COMPETITOR',prob = 0.3,name = 'HIGH DEMAND',payoff = 800)
DT$addTerminal(pNode = 'WITH COMPETITOR',prob = 0.4,name = 'MED DEMAND',payoff = 400)
DT$addTerminal(pNode = 'WITH COMPETITOR',prob = 0.3,name = 'LOW DEMAND',payoff = 200)

DT$addChance(pNode = 'Space Pirates',name = 'WITHOUT COMPETITOR', cost = 0,prob = 0.4)
DT$addTerminal(pNode = 'WITHOUT COMPETITOR',prob = 0.5,name = 'HIGH DEMAND',payoff = 1600)
DT$addTerminal(pNode = 'WITHOUT COMPETITOR',prob = 0.3,name = 'MED DEMAND',payoff = 800)
DT$addTerminal(pNode = 'WITHOUT COMPETITOR',prob = 0.2,name = 'LOW DEMAND',payoff = 400)


DT$update_payoff()
DT$plot_graph()

###question3
DT_2=Tree$new(name='mf_sl',type = 'decision')
DT_2$addChance(pNode = 'mf_sl',name = 'Manufacture', cost = 0,route = 'OPTION A')
DT_2$addTerminal(pNode = 'Manufacture',prob = 0.35,name = 'low',payoff = -20)
DT_2$addTerminal(pNode = 'Manufacture',prob = 0.35,name = 'med',payoff = 40)
DT_2$addTerminal(pNode = 'Manufacture',prob = 0.3,name = 'high',payoff = 100)

DT_2$addChance(pNode = 'mf_sl',name = 'supplier', cost = 0,route = 'OPTION B')
DT_2$addTerminal(pNode = 'supplier',prob = 0.35,name = 'low',payoff = 10)
DT_2$addTerminal(pNode = 'supplier',prob = 0.35,name = 'med',payoff = 45)
DT_2$addTerminal(pNode = 'supplier',prob = 0.3,name = 'high',payoff = 70)
DT_2$update_payoff()
DT_2$plot_graph()

