maximize
obj: 1.2 x_P01,DISC01_T01_ + 3 x_P01,DISC02_T01_ + 3 x_P01,DISC02_T03_ + 0.6 x_P01,DISC03_T01_ + 3 x_P01,DISC04_T02_ + 0.6 x_P02,DISC01_T02_ + 3 x_P02,DISC01_T03_ + 2.4 x_P02,DISC03_T01_ + 3 x_P02,DISC03_T02_ + 1.7999999999999998 x_P02,DISC03_T03_ + 2.4 x_P02,DISC04_T02_ + 1.7999999999999998 x_P02,DISC04_T03_ + 2.4 x_P03,DISC02_T03_ + 3 x_P03,DISC04_T03_ + 2.4 x_P04,DISC02_T01_ + 2.4 x_P04,DISC02_T03_ + 2.4 x_P04,DISC03_T03_ + 2.4 x_P05,DISC01_T01_ + 2.4 x_P05,DISC01_T02_ + 2.4 x_P05,DISC01_T03_ + 1.2 x_P05,DISC02_T02_ + 1.2 x_P05,DISC02_T03_ + 0.6 x_P05,DISC03_T03_ + 0.6 x_P05,DISC04_T02_ + 1.2 x_P05,DISC04_T03_ + 3 x_P06,DISC01_T01_ + 3 x_P06,DISC01_T02_ + 1.7999999999999998 x_P06,DISC02_T01_ + 1.7999999999999998 x_P06,DISC02_T02_ + 1.2 x_P06,DISC02_T03_ + 3 x_P06,DISC03_T01_ + 3 x_P06,DISC03_T02_ + 1.2 x_P06,DISC03_T03_ + 1.7999999999999998 x_P06,DISC04_T02_ + 0.6 x_P06,DISC04_T03_ + 0.2 s_min - 0.1 z_P01,Seg_mat_ - 0.1 z_P01,Seg_vesp_ - 0.1 z_P01,Ter_mat_ - 0.1 z_P01,Ter_vesp_ - 0.1 z_P01,Qua_mat_ - 0.1 z_P01,Qua_vesp_ - 0.1 z_P01,Qui_mat_ - 0.1 z_P01,Qui_vesp_ - 0.1 z_P01,Sex_mat_ - 0.1 z_P01,Sex_vesp_ - 0.1 z_P02,Seg_mat_ - 0.1 z_P02,Seg_vesp_ - 0.1 z_P02,Ter_mat_ - 0.1 z_P02,Ter_vesp_ - 0.1 z_P02,Qua_mat_ - 0.1 z_P02,Qua_vesp_ - 0.1 z_P02,Qui_mat_ - 0.1 z_P02,Qui_vesp_ - 0.1 z_P02,Sex_mat_ - 0.1 z_P02,Sex_vesp_ - 0.1 z_P03,Seg_mat_ - 0.1 z_P03,Seg_vesp_ - 0.1 z_P03,Ter_mat_ - 0.1 z_P03,Ter_vesp_ - 0.1 z_P03,Qua_mat_ - 0.1 z_P03,Qua_vesp_ - 0.1 z_P03,Qui_mat_ - 0.1 z_P03,Qui_vesp_ - 0.1 z_P03,Sex_mat_ - 0.1 z_P03,Sex_vesp_ - 0.1 z_P04,Seg_mat_ - 0.1 z_P04,Seg_vesp_ - 0.1 z_P04,Ter_mat_ - 0.1 z_P04,Ter_vesp_ - 0.1 z_P04,Qua_mat_ - 0.1 z_P04,Qua_vesp_ - 0.1 z_P04,Qui_mat_ - 0.1 z_P04,Qui_vesp_ - 0.1 z_P04,Sex_mat_ - 0.1 z_P04,Sex_vesp_ - 0.1 z_P05,Seg_mat_ - 0.1 z_P05,Seg_vesp_ - 0.1 z_P05,Ter_mat_ - 0.1 z_P05,Ter_vesp_ - 0.1 z_P05,Qua_mat_ - 0.1 z_P05,Qua_vesp_ - 0.1 z_P05,Qui_mat_ - 0.1 z_P05,Qui_vesp_ - 0.1 z_P05,Sex_mat_ - 0.1 z_P05,Sex_vesp_ - 0.1 z_P06,Seg_mat_ - 0.1 z_P06,Seg_vesp_ - 0.1 z_P06,Ter_mat_ - 0.1 z_P06,Ter_vesp_ - 0.1 z_P06,Qua_mat_ - 0.1 z_P06,Qua_vesp_ - 0.1 z_P06,Qui_mat_ - 0.1 z_P06,Qui_vesp_ - 0.1 z_P06,Sex_mat_ - 0.1 z_P06,Sex_vesp_ - 0.1 g_max
subject to
_elegibilidade_P01,DISC01_T01_: 1 x_P01,DISC01_T01_ <= 1
_elegibilidade_P02,DISC01_T01_: 1 x_P02,DISC01_T01_ <= 0
_elegibilidade_P03,DISC01_T01_: 1 x_P03,DISC01_T01_ <= 0
_elegibilidade_P04,DISC01_T01_: 1 x_P04,DISC01_T01_ <= 0
_elegibilidade_P05,DISC01_T01_: 1 x_P05,DISC01_T01_ <= 1
_elegibilidade_P06,DISC01_T01_: 1 x_P06,DISC01_T01_ <= 1
_elegibilidade_P01,DISC01_T02_: 1 x_P01,DISC01_T02_ <= 0
_elegibilidade_P02,DISC01_T02_: 1 x_P02,DISC01_T02_ <= 1
_elegibilidade_P03,DISC01_T02_: 1 x_P03,DISC01_T02_ <= 0
_elegibilidade_P04,DISC01_T02_: 1 x_P04,DISC01_T02_ <= 0
_elegibilidade_P05,DISC01_T02_: 1 x_P05,DISC01_T02_ <= 1
_elegibilidade_P06,DISC01_T02_: 1 x_P06,DISC01_T02_ <= 1
_elegibilidade_P01,DISC01_T03_: 1 x_P01,DISC01_T03_ <= 0
_elegibilidade_P02,DISC01_T03_: 1 x_P02,DISC01_T03_ <= 1
_elegibilidade_P03,DISC01_T03_: 1 x_P03,DISC01_T03_ <= 1
_elegibilidade_P04,DISC01_T03_: 1 x_P04,DISC01_T03_ <= 0
_elegibilidade_P05,DISC01_T03_: 1 x_P05,DISC01_T03_ <= 1
_elegibilidade_P06,DISC01_T03_: 1 x_P06,DISC01_T03_ <= 0
_elegibilidade_P01,DISC02_T01_: 1 x_P01,DISC02_T01_ <= 1
_elegibilidade_P02,DISC02_T01_: 1 x_P02,DISC02_T01_ <= 0
_elegibilidade_P03,DISC02_T01_: 1 x_P03,DISC02_T01_ <= 0
_elegibilidade_P04,DISC02_T01_: 1 x_P04,DISC02_T01_ <= 1
_elegibilidade_P05,DISC02_T01_: 1 x_P05,DISC02_T01_ <= 0
_elegibilidade_P06,DISC02_T01_: 1 x_P06,DISC02_T01_ <= 1
_elegibilidade_P01,DISC02_T02_: 1 x_P01,DISC02_T02_ <= 0
_elegibilidade_P02,DISC02_T02_: 1 x_P02,DISC02_T02_ <= 0
_elegibilidade_P03,DISC02_T02_: 1 x_P03,DISC02_T02_ <= 0
_elegibilidade_P04,DISC02_T02_: 1 x_P04,DISC02_T02_ <= 0
_elegibilidade_P05,DISC02_T02_: 1 x_P05,DISC02_T02_ <= 1
_elegibilidade_P06,DISC02_T02_: 1 x_P06,DISC02_T02_ <= 1
_elegibilidade_P01,DISC02_T03_: 1 x_P01,DISC02_T03_ <= 1
_elegibilidade_P02,DISC02_T03_: 1 x_P02,DISC02_T03_ <= 0
_elegibilidade_P03,DISC02_T03_: 1 x_P03,DISC02_T03_ <= 1
_elegibilidade_P04,DISC02_T03_: 1 x_P04,DISC02_T03_ <= 1
_elegibilidade_P05,DISC02_T03_: 1 x_P05,DISC02_T03_ <= 1
_elegibilidade_P06,DISC02_T03_: 1 x_P06,DISC02_T03_ <= 1
_elegibilidade_P01,DISC03_T01_: 1 x_P01,DISC03_T01_ <= 1
_elegibilidade_P02,DISC03_T01_: 1 x_P02,DISC03_T01_ <= 1
_elegibilidade_P03,DISC03_T01_: 1 x_P03,DISC03_T01_ <= 0
_elegibilidade_P04,DISC03_T01_: 1 x_P04,DISC03_T01_ <= 0
_elegibilidade_P05,DISC03_T01_: 1 x_P05,DISC03_T01_ <= 1
_elegibilidade_P06,DISC03_T01_: 1 x_P06,DISC03_T01_ <= 1
_elegibilidade_P01,DISC03_T02_: 1 x_P01,DISC03_T02_ <= 0
_elegibilidade_P02,DISC03_T02_: 1 x_P02,DISC03_T02_ <= 1
_elegibilidade_P03,DISC03_T02_: 1 x_P03,DISC03_T02_ <= 0
_elegibilidade_P04,DISC03_T02_: 1 x_P04,DISC03_T02_ <= 0
_elegibilidade_P05,DISC03_T02_: 1 x_P05,DISC03_T02_ <= 1
_elegibilidade_P06,DISC03_T02_: 1 x_P06,DISC03_T02_ <= 1
_elegibilidade_P01,DISC03_T03_: 1 x_P01,DISC03_T03_ <= 0
_elegibilidade_P02,DISC03_T03_: 1 x_P02,DISC03_T03_ <= 1
_elegibilidade_P03,DISC03_T03_: 1 x_P03,DISC03_T03_ <= 1
_elegibilidade_P04,DISC03_T03_: 1 x_P04,DISC03_T03_ <= 1
_elegibilidade_P05,DISC03_T03_: 1 x_P05,DISC03_T03_ <= 1
_elegibilidade_P06,DISC03_T03_: 1 x_P06,DISC03_T03_ <= 1
_elegibilidade_P01,DISC04_T01_: 1 x_P01,DISC04_T01_ <= 0
_elegibilidade_P02,DISC04_T01_: 1 x_P02,DISC04_T01_ <= 0
_elegibilidade_P03,DISC04_T01_: 1 x_P03,DISC04_T01_ <= 0
_elegibilidade_P04,DISC04_T01_: 1 x_P04,DISC04_T01_ <= 1
_elegibilidade_P05,DISC04_T01_: 1 x_P05,DISC04_T01_ <= 1
_elegibilidade_P06,DISC04_T01_: 1 x_P06,DISC04_T01_ <= 0
_elegibilidade_P01,DISC04_T02_: 1 x_P01,DISC04_T02_ <= 1
_elegibilidade_P02,DISC04_T02_: 1 x_P02,DISC04_T02_ <= 1
_elegibilidade_P03,DISC04_T02_: 1 x_P03,DISC04_T02_ <= 0
_elegibilidade_P04,DISC04_T02_: 1 x_P04,DISC04_T02_ <= 1
_elegibilidade_P05,DISC04_T02_: 1 x_P05,DISC04_T02_ <= 1
_elegibilidade_P06,DISC04_T02_: 1 x_P06,DISC04_T02_ <= 1
_elegibilidade_P01,DISC04_T03_: 1 x_P01,DISC04_T03_ <= 0
_elegibilidade_P02,DISC04_T03_: 1 x_P02,DISC04_T03_ <= 1
_elegibilidade_P03,DISC04_T03_: 1 x_P03,DISC04_T03_ <= 1
_elegibilidade_P04,DISC04_T03_: 1 x_P04,DISC04_T03_ <= 0
_elegibilidade_P05,DISC04_T03_: 1 x_P05,DISC04_T03_ <= 1
_elegibilidade_P06,DISC04_T03_: 1 x_P06,DISC04_T03_ <= 1
carga_max_P01_: 4 x_P01,DISC01_T01_ + 4 x_P01,DISC01_T02_ + 4 x_P01,DISC01_T03_ + 4 x_P01,DISC02_T01_ + 4 x_P01,DISC02_T02_ + 4 x_P01,DISC02_T03_ + 4 x_P01,DISC03_T01_ + 4 x_P01,DISC03_T02_ + 4 x_P01,DISC03_T03_ + 4 x_P01,DISC04_T01_ + 4 x_P01,DISC04_T02_ + 4 x_P01,DISC04_T03_ <= 12
carga_max_P02_: 4 x_P02,DISC01_T01_ + 4 x_P02,DISC01_T02_ + 4 x_P02,DISC01_T03_ + 4 x_P02,DISC02_T01_ + 4 x_P02,DISC02_T02_ + 4 x_P02,DISC02_T03_ + 4 x_P02,DISC03_T01_ + 4 x_P02,DISC03_T02_ + 4 x_P02,DISC03_T03_ + 4 x_P02,DISC04_T01_ + 4 x_P02,DISC04_T02_ + 4 x_P02,DISC04_T03_ <= 12
carga_max_P03_: 4 x_P03,DISC01_T01_ + 4 x_P03,DISC01_T02_ + 4 x_P03,DISC01_T03_ + 4 x_P03,DISC02_T01_ + 4 x_P03,DISC02_T02_ + 4 x_P03,DISC02_T03_ + 4 x_P03,DISC03_T01_ + 4 x_P03,DISC03_T02_ + 4 x_P03,DISC03_T03_ + 4 x_P03,DISC04_T01_ + 4 x_P03,DISC04_T02_ + 4 x_P03,DISC04_T03_ <= 12
carga_max_P04_: 4 x_P04,DISC01_T01_ + 4 x_P04,DISC01_T02_ + 4 x_P04,DISC01_T03_ + 4 x_P04,DISC02_T01_ + 4 x_P04,DISC02_T02_ + 4 x_P04,DISC02_T03_ + 4 x_P04,DISC03_T01_ + 4 x_P04,DISC03_T02_ + 4 x_P04,DISC03_T03_ + 4 x_P04,DISC04_T01_ + 4 x_P04,DISC04_T02_ + 4 x_P04,DISC04_T03_ <= 12
carga_max_P05_: 4 x_P05,DISC01_T01_ + 4 x_P05,DISC01_T02_ + 4 x_P05,DISC01_T03_ + 4 x_P05,DISC02_T01_ + 4 x_P05,DISC02_T02_ + 4 x_P05,DISC02_T03_ + 4 x_P05,DISC03_T01_ + 4 x_P05,DISC03_T02_ + 4 x_P05,DISC03_T03_ + 4 x_P05,DISC04_T01_ + 4 x_P05,DISC04_T02_ + 4 x_P05,DISC04_T03_ <= 12
carga_max_P06_: 4 x_P06,DISC01_T01_ + 4 x_P06,DISC01_T02_ + 4 x_P06,DISC01_T03_ + 4 x_P06,DISC02_T01_ + 4 x_P06,DISC02_T02_ + 4 x_P06,DISC02_T03_ + 4 x_P06,DISC03_T01_ + 4 x_P06,DISC03_T02_ + 4 x_P06,DISC03_T03_ + 4 x_P06,DISC04_T01_ + 4 x_P06,DISC04_T02_ + 4 x_P06,DISC04_T03_ <= 12
piso_satisfacao_P01_: -2 x_P01,DISC01_T01_ - 5 x_P01,DISC02_T01_ - 5 x_P01,DISC02_T03_ - 1 x_P01,DISC03_T01_ - 5 x_P01,DISC04_T02_ + 1 s_min <= 0
piso_satisfacao_P02_: -1 x_P02,DISC01_T02_ - 5 x_P02,DISC01_T03_ - 4 x_P02,DISC03_T01_ - 5 x_P02,DISC03_T02_ - 3 x_P02,DISC03_T03_ - 4 x_P02,DISC04_T02_ - 3 x_P02,DISC04_T03_ + 1 s_min <= 0
piso_satisfacao_P03_: -4 x_P03,DISC02_T03_ - 5 x_P03,DISC04_T03_ + 1 s_min <= 0
piso_satisfacao_P04_: -4 x_P04,DISC02_T01_ - 4 x_P04,DISC02_T03_ - 4 x_P04,DISC03_T03_ + 1 s_min <= 0
piso_satisfacao_P05_: -4 x_P05,DISC01_T01_ - 4 x_P05,DISC01_T02_ - 4 x_P05,DISC01_T03_ - 2 x_P05,DISC02_T02_ - 2 x_P05,DISC02_T03_ - 1 x_P05,DISC03_T03_ - 1 x_P05,DISC04_T02_ - 2 x_P05,DISC04_T03_ + 1 s_min <= 0
piso_satisfacao_P06_: -5 x_P06,DISC01_T01_ - 5 x_P06,DISC01_T02_ - 3 x_P06,DISC02_T01_ - 3 x_P06,DISC02_T02_ - 2 x_P06,DISC02_T03_ - 5 x_P06,DISC03_T01_ - 5 x_P06,DISC03_T02_ - 2 x_P06,DISC03_T03_ - 3 x_P06,DISC04_T02_ - 1 x_P06,DISC04_T03_ + 1 s_min <= 0
liga_disciplina_P01,DISC01_T01_: 1 x_P01,DISC01_T01_ - 1 g_P01,DISC01_ <= 0
liga_disciplina_P02,DISC01_T01_: 1 x_P02,DISC01_T01_ - 1 g_P02,DISC01_ <= 0
liga_disciplina_P03,DISC01_T01_: 1 x_P03,DISC01_T01_ - 1 g_P03,DISC01_ <= 0
liga_disciplina_P04,DISC01_T01_: 1 x_P04,DISC01_T01_ - 1 g_P04,DISC01_ <= 0
liga_disciplina_P05,DISC01_T01_: 1 x_P05,DISC01_T01_ - 1 g_P05,DISC01_ <= 0
liga_disciplina_P06,DISC01_T01_: 1 x_P06,DISC01_T01_ - 1 g_P06,DISC01_ <= 0
liga_disciplina_P01,DISC01_T02_: 1 x_P01,DISC01_T02_ - 1 g_P01,DISC01_ <= 0
liga_disciplina_P02,DISC01_T02_: 1 x_P02,DISC01_T02_ - 1 g_P02,DISC01_ <= 0
liga_disciplina_P03,DISC01_T02_: 1 x_P03,DISC01_T02_ - 1 g_P03,DISC01_ <= 0
liga_disciplina_P04,DISC01_T02_: 1 x_P04,DISC01_T02_ - 1 g_P04,DISC01_ <= 0
liga_disciplina_P05,DISC01_T02_: 1 x_P05,DISC01_T02_ - 1 g_P05,DISC01_ <= 0
liga_disciplina_P06,DISC01_T02_: 1 x_P06,DISC01_T02_ - 1 g_P06,DISC01_ <= 0
liga_disciplina_P01,DISC01_T03_: 1 x_P01,DISC01_T03_ - 1 g_P01,DISC01_ <= 0
liga_disciplina_P02,DISC01_T03_: 1 x_P02,DISC01_T03_ - 1 g_P02,DISC01_ <= 0
liga_disciplina_P03,DISC01_T03_: 1 x_P03,DISC01_T03_ - 1 g_P03,DISC01_ <= 0
liga_disciplina_P04,DISC01_T03_: 1 x_P04,DISC01_T03_ - 1 g_P04,DISC01_ <= 0
liga_disciplina_P05,DISC01_T03_: 1 x_P05,DISC01_T03_ - 1 g_P05,DISC01_ <= 0
liga_disciplina_P06,DISC01_T03_: 1 x_P06,DISC01_T03_ - 1 g_P06,DISC01_ <= 0
liga_disciplina_P01,DISC02_T01_: 1 x_P01,DISC02_T01_ - 1 g_P01,DISC02_ <= 0
liga_disciplina_P02,DISC02_T01_: 1 x_P02,DISC02_T01_ - 1 g_P02,DISC02_ <= 0
liga_disciplina_P03,DISC02_T01_: 1 x_P03,DISC02_T01_ - 1 g_P03,DISC02_ <= 0
liga_disciplina_P04,DISC02_T01_: 1 x_P04,DISC02_T01_ - 1 g_P04,DISC02_ <= 0
liga_disciplina_P05,DISC02_T01_: 1 x_P05,DISC02_T01_ - 1 g_P05,DISC02_ <= 0
liga_disciplina_P06,DISC02_T01_: 1 x_P06,DISC02_T01_ - 1 g_P06,DISC02_ <= 0
liga_disciplina_P01,DISC02_T02_: 1 x_P01,DISC02_T02_ - 1 g_P01,DISC02_ <= 0
liga_disciplina_P02,DISC02_T02_: 1 x_P02,DISC02_T02_ - 1 g_P02,DISC02_ <= 0
liga_disciplina_P03,DISC02_T02_: 1 x_P03,DISC02_T02_ - 1 g_P03,DISC02_ <= 0
liga_disciplina_P04,DISC02_T02_: 1 x_P04,DISC02_T02_ - 1 g_P04,DISC02_ <= 0
liga_disciplina_P05,DISC02_T02_: 1 x_P05,DISC02_T02_ - 1 g_P05,DISC02_ <= 0
liga_disciplina_P06,DISC02_T02_: 1 x_P06,DISC02_T02_ - 1 g_P06,DISC02_ <= 0
liga_disciplina_P01,DISC02_T03_: 1 x_P01,DISC02_T03_ - 1 g_P01,DISC02_ <= 0
liga_disciplina_P02,DISC02_T03_: 1 x_P02,DISC02_T03_ - 1 g_P02,DISC02_ <= 0
liga_disciplina_P03,DISC02_T03_: 1 x_P03,DISC02_T03_ - 1 g_P03,DISC02_ <= 0
liga_disciplina_P04,DISC02_T03_: 1 x_P04,DISC02_T03_ - 1 g_P04,DISC02_ <= 0
liga_disciplina_P05,DISC02_T03_: 1 x_P05,DISC02_T03_ - 1 g_P05,DISC02_ <= 0
liga_disciplina_P06,DISC02_T03_: 1 x_P06,DISC02_T03_ - 1 g_P06,DISC02_ <= 0
liga_disciplina_P01,DISC03_T01_: 1 x_P01,DISC03_T01_ - 1 g_P01,DISC03_ <= 0
liga_disciplina_P02,DISC03_T01_: 1 x_P02,DISC03_T01_ - 1 g_P02,DISC03_ <= 0
liga_disciplina_P03,DISC03_T01_: 1 x_P03,DISC03_T01_ - 1 g_P03,DISC03_ <= 0
liga_disciplina_P04,DISC03_T01_: 1 x_P04,DISC03_T01_ - 1 g_P04,DISC03_ <= 0
liga_disciplina_P05,DISC03_T01_: 1 x_P05,DISC03_T01_ - 1 g_P05,DISC03_ <= 0
liga_disciplina_P06,DISC03_T01_: 1 x_P06,DISC03_T01_ - 1 g_P06,DISC03_ <= 0
liga_disciplina_P01,DISC03_T02_: 1 x_P01,DISC03_T02_ - 1 g_P01,DISC03_ <= 0
liga_disciplina_P02,DISC03_T02_: 1 x_P02,DISC03_T02_ - 1 g_P02,DISC03_ <= 0
liga_disciplina_P03,DISC03_T02_: 1 x_P03,DISC03_T02_ - 1 g_P03,DISC03_ <= 0
liga_disciplina_P04,DISC03_T02_: 1 x_P04,DISC03_T02_ - 1 g_P04,DISC03_ <= 0
liga_disciplina_P05,DISC03_T02_: 1 x_P05,DISC03_T02_ - 1 g_P05,DISC03_ <= 0
liga_disciplina_P06,DISC03_T02_: 1 x_P06,DISC03_T02_ - 1 g_P06,DISC03_ <= 0
liga_disciplina_P01,DISC03_T03_: 1 x_P01,DISC03_T03_ - 1 g_P01,DISC03_ <= 0
liga_disciplina_P02,DISC03_T03_: 1 x_P02,DISC03_T03_ - 1 g_P02,DISC03_ <= 0
liga_disciplina_P03,DISC03_T03_: 1 x_P03,DISC03_T03_ - 1 g_P03,DISC03_ <= 0
liga_disciplina_P04,DISC03_T03_: 1 x_P04,DISC03_T03_ - 1 g_P04,DISC03_ <= 0
liga_disciplina_P05,DISC03_T03_: 1 x_P05,DISC03_T03_ - 1 g_P05,DISC03_ <= 0
liga_disciplina_P06,DISC03_T03_: 1 x_P06,DISC03_T03_ - 1 g_P06,DISC03_ <= 0
liga_disciplina_P01,DISC04_T01_: 1 x_P01,DISC04_T01_ - 1 g_P01,DISC04_ <= 0
liga_disciplina_P02,DISC04_T01_: 1 x_P02,DISC04_T01_ - 1 g_P02,DISC04_ <= 0
liga_disciplina_P03,DISC04_T01_: 1 x_P03,DISC04_T01_ - 1 g_P03,DISC04_ <= 0
liga_disciplina_P04,DISC04_T01_: 1 x_P04,DISC04_T01_ - 1 g_P04,DISC04_ <= 0
liga_disciplina_P05,DISC04_T01_: 1 x_P05,DISC04_T01_ - 1 g_P05,DISC04_ <= 0
liga_disciplina_P06,DISC04_T01_: 1 x_P06,DISC04_T01_ - 1 g_P06,DISC04_ <= 0
liga_disciplina_P01,DISC04_T02_: 1 x_P01,DISC04_T02_ - 1 g_P01,DISC04_ <= 0
liga_disciplina_P02,DISC04_T02_: 1 x_P02,DISC04_T02_ - 1 g_P02,DISC04_ <= 0
liga_disciplina_P03,DISC04_T02_: 1 x_P03,DISC04_T02_ - 1 g_P03,DISC04_ <= 0
liga_disciplina_P04,DISC04_T02_: 1 x_P04,DISC04_T02_ - 1 g_P04,DISC04_ <= 0
liga_disciplina_P05,DISC04_T02_: 1 x_P05,DISC04_T02_ - 1 g_P05,DISC04_ <= 0
liga_disciplina_P06,DISC04_T02_: 1 x_P06,DISC04_T02_ - 1 g_P06,DISC04_ <= 0
liga_disciplina_P01,DISC04_T03_: 1 x_P01,DISC04_T03_ - 1 g_P01,DISC04_ <= 0
liga_disciplina_P02,DISC04_T03_: 1 x_P02,DISC04_T03_ - 1 g_P02,DISC04_ <= 0
liga_disciplina_P03,DISC04_T03_: 1 x_P03,DISC04_T03_ - 1 g_P03,DISC04_ <= 0
liga_disciplina_P04,DISC04_T03_: 1 x_P04,DISC04_T03_ - 1 g_P04,DISC04_ <= 0
liga_disciplina_P05,DISC04_T03_: 1 x_P05,DISC04_T03_ - 1 g_P05,DISC04_ <= 0
liga_disciplina_P06,DISC04_T03_: 1 x_P06,DISC04_T03_ - 1 g_P06,DISC04_ <= 0
liga_disciplina_reversa_P01,DISC01_: -1 x_P01,DISC01_T01_ - 1 x_P01,DISC01_T02_ - 1 x_P01,DISC01_T03_ + 1 g_P01,DISC01_ <= 0
liga_disciplina_reversa_P02,DISC01_: -1 x_P02,DISC01_T01_ - 1 x_P02,DISC01_T02_ - 1 x_P02,DISC01_T03_ + 1 g_P02,DISC01_ <= 0
liga_disciplina_reversa_P03,DISC01_: -1 x_P03,DISC01_T01_ - 1 x_P03,DISC01_T02_ - 1 x_P03,DISC01_T03_ + 1 g_P03,DISC01_ <= 0
liga_disciplina_reversa_P04,DISC01_: -1 x_P04,DISC01_T01_ - 1 x_P04,DISC01_T02_ - 1 x_P04,DISC01_T03_ + 1 g_P04,DISC01_ <= 0
liga_disciplina_reversa_P05,DISC01_: -1 x_P05,DISC01_T01_ - 1 x_P05,DISC01_T02_ - 1 x_P05,DISC01_T03_ + 1 g_P05,DISC01_ <= 0
liga_disciplina_reversa_P06,DISC01_: -1 x_P06,DISC01_T01_ - 1 x_P06,DISC01_T02_ - 1 x_P06,DISC01_T03_ + 1 g_P06,DISC01_ <= 0
liga_disciplina_reversa_P01,DISC02_: -1 x_P01,DISC02_T01_ - 1 x_P01,DISC02_T02_ - 1 x_P01,DISC02_T03_ + 1 g_P01,DISC02_ <= 0
liga_disciplina_reversa_P02,DISC02_: -1 x_P02,DISC02_T01_ - 1 x_P02,DISC02_T02_ - 1 x_P02,DISC02_T03_ + 1 g_P02,DISC02_ <= 0
liga_disciplina_reversa_P03,DISC02_: -1 x_P03,DISC02_T01_ - 1 x_P03,DISC02_T02_ - 1 x_P03,DISC02_T03_ + 1 g_P03,DISC02_ <= 0
liga_disciplina_reversa_P04,DISC02_: -1 x_P04,DISC02_T01_ - 1 x_P04,DISC02_T02_ - 1 x_P04,DISC02_T03_ + 1 g_P04,DISC02_ <= 0
liga_disciplina_reversa_P05,DISC02_: -1 x_P05,DISC02_T01_ - 1 x_P05,DISC02_T02_ - 1 x_P05,DISC02_T03_ + 1 g_P05,DISC02_ <= 0
liga_disciplina_reversa_P06,DISC02_: -1 x_P06,DISC02_T01_ - 1 x_P06,DISC02_T02_ - 1 x_P06,DISC02_T03_ + 1 g_P06,DISC02_ <= 0
liga_disciplina_reversa_P01,DISC03_: -1 x_P01,DISC03_T01_ - 1 x_P01,DISC03_T02_ - 1 x_P01,DISC03_T03_ + 1 g_P01,DISC03_ <= 0
liga_disciplina_reversa_P02,DISC03_: -1 x_P02,DISC03_T01_ - 1 x_P02,DISC03_T02_ - 1 x_P02,DISC03_T03_ + 1 g_P02,DISC03_ <= 0
liga_disciplina_reversa_P03,DISC03_: -1 x_P03,DISC03_T01_ - 1 x_P03,DISC03_T02_ - 1 x_P03,DISC03_T03_ + 1 g_P03,DISC03_ <= 0
liga_disciplina_reversa_P04,DISC03_: -1 x_P04,DISC03_T01_ - 1 x_P04,DISC03_T02_ - 1 x_P04,DISC03_T03_ + 1 g_P04,DISC03_ <= 0
liga_disciplina_reversa_P05,DISC03_: -1 x_P05,DISC03_T01_ - 1 x_P05,DISC03_T02_ - 1 x_P05,DISC03_T03_ + 1 g_P05,DISC03_ <= 0
liga_disciplina_reversa_P06,DISC03_: -1 x_P06,DISC03_T01_ - 1 x_P06,DISC03_T02_ - 1 x_P06,DISC03_T03_ + 1 g_P06,DISC03_ <= 0
liga_disciplina_reversa_P01,DISC04_: -1 x_P01,DISC04_T01_ - 1 x_P01,DISC04_T02_ - 1 x_P01,DISC04_T03_ + 1 g_P01,DISC04_ <= 0
liga_disciplina_reversa_P02,DISC04_: -1 x_P02,DISC04_T01_ - 1 x_P02,DISC04_T02_ - 1 x_P02,DISC04_T03_ + 1 g_P02,DISC04_ <= 0
liga_disciplina_reversa_P03,DISC04_: -1 x_P03,DISC04_T01_ - 1 x_P03,DISC04_T02_ - 1 x_P03,DISC04_T03_ + 1 g_P03,DISC04_ <= 0
liga_disciplina_reversa_P04,DISC04_: -1 x_P04,DISC04_T01_ - 1 x_P04,DISC04_T02_ - 1 x_P04,DISC04_T03_ + 1 g_P04,DISC04_ <= 0
liga_disciplina_reversa_P05,DISC04_: -1 x_P05,DISC04_T01_ - 1 x_P05,DISC04_T02_ - 1 x_P05,DISC04_T03_ + 1 g_P05,DISC04_ <= 0
liga_disciplina_reversa_P06,DISC04_: -1 x_P06,DISC04_T01_ - 1 x_P06,DISC04_T02_ - 1 x_P06,DISC04_T03_ + 1 g_P06,DISC04_ <= 0
conflito_intervalo_P01,1_: 1 x_P01,DISC01_T01_ + 1 x_P01,DISC03_T02_ <= 1
conflito_intervalo_P02,1_: 1 x_P02,DISC01_T01_ + 1 x_P02,DISC03_T02_ <= 1
conflito_intervalo_P03,1_: 1 x_P03,DISC01_T01_ + 1 x_P03,DISC03_T02_ <= 1
conflito_intervalo_P04,1_: 1 x_P04,DISC01_T01_ + 1 x_P04,DISC03_T02_ <= 1
conflito_intervalo_P05,1_: 1 x_P05,DISC01_T01_ + 1 x_P05,DISC03_T02_ <= 1
conflito_intervalo_P06,1_: 1 x_P06,DISC01_T01_ + 1 x_P06,DISC03_T02_ <= 1
conflito_intervalo_P01,2_: 1 x_P01,DISC01_T01_ + 1 x_P01,DISC04_T01_ <= 1
conflito_intervalo_P02,2_: 1 x_P02,DISC01_T01_ + 1 x_P02,DISC04_T01_ <= 1
conflito_intervalo_P03,2_: 1 x_P03,DISC01_T01_ + 1 x_P03,DISC04_T01_ <= 1
conflito_intervalo_P04,2_: 1 x_P04,DISC01_T01_ + 1 x_P04,DISC04_T01_ <= 1
conflito_intervalo_P05,2_: 1 x_P05,DISC01_T01_ + 1 x_P05,DISC04_T01_ <= 1
conflito_intervalo_P06,2_: 1 x_P06,DISC01_T01_ + 1 x_P06,DISC04_T01_ <= 1
conflito_intervalo_P01,3_: 1 x_P01,DISC01_T02_ + 1 x_P01,DISC02_T03_ <= 1
conflito_intervalo_P02,3_: 1 x_P02,DISC01_T02_ + 1 x_P02,DISC02_T03_ <= 1
conflito_intervalo_P03,3_: 1 x_P03,DISC01_T02_ + 1 x_P03,DISC02_T03_ <= 1
conflito_intervalo_P04,3_: 1 x_P04,DISC01_T02_ + 1 x_P04,DISC02_T03_ <= 1
conflito_intervalo_P05,3_: 1 x_P05,DISC01_T02_ + 1 x_P05,DISC02_T03_ <= 1
conflito_intervalo_P06,3_: 1 x_P06,DISC01_T02_ + 1 x_P06,DISC02_T03_ <= 1
conflito_intervalo_P01,4_: 1 x_P01,DISC01_T02_ + 1 x_P01,DISC03_T01_ <= 1
conflito_intervalo_P02,4_: 1 x_P02,DISC01_T02_ + 1 x_P02,DISC03_T01_ <= 1
conflito_intervalo_P03,4_: 1 x_P03,DISC01_T02_ + 1 x_P03,DISC03_T01_ <= 1
conflito_intervalo_P04,4_: 1 x_P04,DISC01_T02_ + 1 x_P04,DISC03_T01_ <= 1
conflito_intervalo_P05,4_: 1 x_P05,DISC01_T02_ + 1 x_P05,DISC03_T01_ <= 1
conflito_intervalo_P06,4_: 1 x_P06,DISC01_T02_ + 1 x_P06,DISC03_T01_ <= 1
conflito_intervalo_P01,5_: 1 x_P01,DISC01_T02_ + 1 x_P01,DISC04_T03_ <= 1
conflito_intervalo_P02,5_: 1 x_P02,DISC01_T02_ + 1 x_P02,DISC04_T03_ <= 1
conflito_intervalo_P03,5_: 1 x_P03,DISC01_T02_ + 1 x_P03,DISC04_T03_ <= 1
conflito_intervalo_P04,5_: 1 x_P04,DISC01_T02_ + 1 x_P04,DISC04_T03_ <= 1
conflito_intervalo_P05,5_: 1 x_P05,DISC01_T02_ + 1 x_P05,DISC04_T03_ <= 1
conflito_intervalo_P06,5_: 1 x_P06,DISC01_T02_ + 1 x_P06,DISC04_T03_ <= 1
conflito_intervalo_P01,6_: 1 x_P01,DISC02_T01_ + 1 x_P01,DISC03_T01_ <= 1
conflito_intervalo_P02,6_: 1 x_P02,DISC02_T01_ + 1 x_P02,DISC03_T01_ <= 1
conflito_intervalo_P03,6_: 1 x_P03,DISC02_T01_ + 1 x_P03,DISC03_T01_ <= 1
conflito_intervalo_P04,6_: 1 x_P04,DISC02_T01_ + 1 x_P04,DISC03_T01_ <= 1
conflito_intervalo_P05,6_: 1 x_P05,DISC02_T01_ + 1 x_P05,DISC03_T01_ <= 1
conflito_intervalo_P06,6_: 1 x_P06,DISC02_T01_ + 1 x_P06,DISC03_T01_ <= 1
conflito_intervalo_P01,7_: 1 x_P01,DISC02_T02_ + 1 x_P01,DISC03_T03_ <= 1
conflito_intervalo_P02,7_: 1 x_P02,DISC02_T02_ + 1 x_P02,DISC03_T03_ <= 1
conflito_intervalo_P03,7_: 1 x_P03,DISC02_T02_ + 1 x_P03,DISC03_T03_ <= 1
conflito_intervalo_P04,7_: 1 x_P04,DISC02_T02_ + 1 x_P04,DISC03_T03_ <= 1
conflito_intervalo_P05,7_: 1 x_P05,DISC02_T02_ + 1 x_P05,DISC03_T03_ <= 1
conflito_intervalo_P06,7_: 1 x_P06,DISC02_T02_ + 1 x_P06,DISC03_T03_ <= 1
conflito_intervalo_P01,8_: 1 x_P01,DISC02_T03_ + 1 x_P01,DISC03_T01_ <= 1
conflito_intervalo_P02,8_: 1 x_P02,DISC02_T03_ + 1 x_P02,DISC03_T01_ <= 1
conflito_intervalo_P03,8_: 1 x_P03,DISC02_T03_ + 1 x_P03,DISC03_T01_ <= 1
conflito_intervalo_P04,8_: 1 x_P04,DISC02_T03_ + 1 x_P04,DISC03_T01_ <= 1
conflito_intervalo_P05,8_: 1 x_P05,DISC02_T03_ + 1 x_P05,DISC03_T01_ <= 1
conflito_intervalo_P06,8_: 1 x_P06,DISC02_T03_ + 1 x_P06,DISC03_T01_ <= 1
conflito_intervalo_P01,9_: 1 x_P01,DISC02_T03_ + 1 x_P01,DISC04_T02_ <= 1
conflito_intervalo_P02,9_: 1 x_P02,DISC02_T03_ + 1 x_P02,DISC04_T02_ <= 1
conflito_intervalo_P03,9_: 1 x_P03,DISC02_T03_ + 1 x_P03,DISC04_T02_ <= 1
conflito_intervalo_P04,9_: 1 x_P04,DISC02_T03_ + 1 x_P04,DISC04_T02_ <= 1
conflito_intervalo_P05,9_: 1 x_P05,DISC02_T03_ + 1 x_P05,DISC04_T02_ <= 1
conflito_intervalo_P06,9_: 1 x_P06,DISC02_T03_ + 1 x_P06,DISC04_T02_ <= 1
liga_turno_P01,DISC01_T01,Ter_vesp_: 1 x_P01,DISC01_T01_ - 1 z_P01,Ter_vesp_ <= 0
liga_turno_P01,DISC01_T01,Qua_mat_: 1 x_P01,DISC01_T01_ - 1 z_P01,Qua_mat_ <= 0
liga_turno_P01,DISC01_T02,Seg_vesp_: 1 x_P01,DISC01_T02_ - 1 z_P01,Seg_vesp_ <= 0
liga_turno_P01,DISC01_T02,Sex_mat_: 1 x_P01,DISC01_T02_ - 1 z_P01,Sex_mat_ <= 0
liga_turno_P01,DISC01_T03,Seg_vesp_: 1 x_P01,DISC01_T03_ - 1 z_P01,Seg_vesp_ <= 0
liga_turno_P01,DISC01_T03,Sex_vesp_: 1 x_P01,DISC01_T03_ - 1 z_P01,Sex_vesp_ <= 0
liga_turno_P01,DISC02_T01,Seg_mat_: 1 x_P01,DISC02_T01_ - 1 z_P01,Seg_mat_ <= 0
liga_turno_P01,DISC02_T01,Qui_mat_: 1 x_P01,DISC02_T01_ - 1 z_P01,Qui_mat_ <= 0
liga_turno_P01,DISC02_T02,Seg_mat_: 1 x_P01,DISC02_T02_ - 1 z_P01,Seg_mat_ <= 0
liga_turno_P01,DISC02_T02,Sex_mat_: 1 x_P01,DISC02_T02_ - 1 z_P01,Sex_mat_ <= 0
liga_turno_P01,DISC02_T03,Ter_vesp_: 1 x_P01,DISC02_T03_ - 1 z_P01,Ter_vesp_ <= 0
liga_turno_P01,DISC02_T03,Sex_mat_: 1 x_P01,DISC02_T03_ - 1 z_P01,Sex_mat_ <= 0
liga_turno_P01,DISC03_T01,Qui_mat_: 1 x_P01,DISC03_T01_ - 1 z_P01,Qui_mat_ <= 0
liga_turno_P01,DISC03_T01,Sex_mat_: 1 x_P01,DISC03_T01_ - 1 z_P01,Sex_mat_ <= 0
liga_turno_P01,DISC03_T02,Ter_vesp_: 1 x_P01,DISC03_T02_ - 1 z_P01,Ter_vesp_ <= 0
liga_turno_P01,DISC03_T02,Qui_vesp_: 1 x_P01,DISC03_T02_ - 1 z_P01,Qui_vesp_ <= 0
liga_turno_P01,DISC03_T03,Seg_mat_: 1 x_P01,DISC03_T03_ - 1 z_P01,Seg_mat_ <= 0
liga_turno_P01,DISC03_T03,Ter_mat_: 1 x_P01,DISC03_T03_ - 1 z_P01,Ter_mat_ <= 0
liga_turno_P01,DISC04_T01,Ter_mat_: 1 x_P01,DISC04_T01_ - 1 z_P01,Ter_mat_ <= 0
liga_turno_P01,DISC04_T01,Qua_mat_: 1 x_P01,DISC04_T01_ - 1 z_P01,Qua_mat_ <= 0
liga_turno_P01,DISC04_T02,Ter_vesp_: 1 x_P01,DISC04_T02_ - 1 z_P01,Ter_vesp_ <= 0
liga_turno_P01,DISC04_T02,Qua_vesp_: 1 x_P01,DISC04_T02_ - 1 z_P01,Qua_vesp_ <= 0
liga_turno_P01,DISC04_T03,Seg_vesp_: 1 x_P01,DISC04_T03_ - 1 z_P01,Seg_vesp_ <= 0
liga_turno_P01,DISC04_T03,Qui_mat_: 1 x_P01,DISC04_T03_ - 1 z_P01,Qui_mat_ <= 0
liga_turno_P02,DISC01_T01,Ter_vesp_: 1 x_P02,DISC01_T01_ - 1 z_P02,Ter_vesp_ <= 0
liga_turno_P02,DISC01_T01,Qua_mat_: 1 x_P02,DISC01_T01_ - 1 z_P02,Qua_mat_ <= 0
liga_turno_P02,DISC01_T02,Seg_vesp_: 1 x_P02,DISC01_T02_ - 1 z_P02,Seg_vesp_ <= 0
liga_turno_P02,DISC01_T02,Sex_mat_: 1 x_P02,DISC01_T02_ - 1 z_P02,Sex_mat_ <= 0
liga_turno_P02,DISC01_T03,Seg_vesp_: 1 x_P02,DISC01_T03_ - 1 z_P02,Seg_vesp_ <= 0
liga_turno_P02,DISC01_T03,Sex_vesp_: 1 x_P02,DISC01_T03_ - 1 z_P02,Sex_vesp_ <= 0
liga_turno_P02,DISC02_T01,Seg_mat_: 1 x_P02,DISC02_T01_ - 1 z_P02,Seg_mat_ <= 0
liga_turno_P02,DISC02_T01,Qui_mat_: 1 x_P02,DISC02_T01_ - 1 z_P02,Qui_mat_ <= 0
liga_turno_P02,DISC02_T02,Seg_mat_: 1 x_P02,DISC02_T02_ - 1 z_P02,Seg_mat_ <= 0
liga_turno_P02,DISC02_T02,Sex_mat_: 1 x_P02,DISC02_T02_ - 1 z_P02,Sex_mat_ <= 0
liga_turno_P02,DISC02_T03,Ter_vesp_: 1 x_P02,DISC02_T03_ - 1 z_P02,Ter_vesp_ <= 0
liga_turno_P02,DISC02_T03,Sex_mat_: 1 x_P02,DISC02_T03_ - 1 z_P02,Sex_mat_ <= 0
liga_turno_P02,DISC03_T01,Qui_mat_: 1 x_P02,DISC03_T01_ - 1 z_P02,Qui_mat_ <= 0
liga_turno_P02,DISC03_T01,Sex_mat_: 1 x_P02,DISC03_T01_ - 1 z_P02,Sex_mat_ <= 0
liga_turno_P02,DISC03_T02,Ter_vesp_: 1 x_P02,DISC03_T02_ - 1 z_P02,Ter_vesp_ <= 0
liga_turno_P02,DISC03_T02,Qui_vesp_: 1 x_P02,DISC03_T02_ - 1 z_P02,Qui_vesp_ <= 0
liga_turno_P02,DISC03_T03,Seg_mat_: 1 x_P02,DISC03_T03_ - 1 z_P02,Seg_mat_ <= 0
liga_turno_P02,DISC03_T03,Ter_mat_: 1 x_P02,DISC03_T03_ - 1 z_P02,Ter_mat_ <= 0
liga_turno_P02,DISC04_T01,Ter_mat_: 1 x_P02,DISC04_T01_ - 1 z_P02,Ter_mat_ <= 0
liga_turno_P02,DISC04_T01,Qua_mat_: 1 x_P02,DISC04_T01_ - 1 z_P02,Qua_mat_ <= 0
liga_turno_P02,DISC04_T02,Ter_vesp_: 1 x_P02,DISC04_T02_ - 1 z_P02,Ter_vesp_ <= 0
liga_turno_P02,DISC04_T02,Qua_vesp_: 1 x_P02,DISC04_T02_ - 1 z_P02,Qua_vesp_ <= 0
liga_turno_P02,DISC04_T03,Seg_vesp_: 1 x_P02,DISC04_T03_ - 1 z_P02,Seg_vesp_ <= 0
liga_turno_P02,DISC04_T03,Qui_mat_: 1 x_P02,DISC04_T03_ - 1 z_P02,Qui_mat_ <= 0
liga_turno_P03,DISC01_T01,Ter_vesp_: 1 x_P03,DISC01_T01_ - 1 z_P03,Ter_vesp_ <= 0
liga_turno_P03,DISC01_T01,Qua_mat_: 1 x_P03,DISC01_T01_ - 1 z_P03,Qua_mat_ <= 0
liga_turno_P03,DISC01_T02,Seg_vesp_: 1 x_P03,DISC01_T02_ - 1 z_P03,Seg_vesp_ <= 0
liga_turno_P03,DISC01_T02,Sex_mat_: 1 x_P03,DISC01_T02_ - 1 z_P03,Sex_mat_ <= 0
liga_turno_P03,DISC01_T03,Seg_vesp_: 1 x_P03,DISC01_T03_ - 1 z_P03,Seg_vesp_ <= 0
liga_turno_P03,DISC01_T03,Sex_vesp_: 1 x_P03,DISC01_T03_ - 1 z_P03,Sex_vesp_ <= 0
liga_turno_P03,DISC02_T01,Seg_mat_: 1 x_P03,DISC02_T01_ - 1 z_P03,Seg_mat_ <= 0
liga_turno_P03,DISC02_T01,Qui_mat_: 1 x_P03,DISC02_T01_ - 1 z_P03,Qui_mat_ <= 0
liga_turno_P03,DISC02_T02,Seg_mat_: 1 x_P03,DISC02_T02_ - 1 z_P03,Seg_mat_ <= 0
liga_turno_P03,DISC02_T02,Sex_mat_: 1 x_P03,DISC02_T02_ - 1 z_P03,Sex_mat_ <= 0
liga_turno_P03,DISC02_T03,Ter_vesp_: 1 x_P03,DISC02_T03_ - 1 z_P03,Ter_vesp_ <= 0
liga_turno_P03,DISC02_T03,Sex_mat_: 1 x_P03,DISC02_T03_ - 1 z_P03,Sex_mat_ <= 0
liga_turno_P03,DISC03_T01,Qui_mat_: 1 x_P03,DISC03_T01_ - 1 z_P03,Qui_mat_ <= 0
liga_turno_P03,DISC03_T01,Sex_mat_: 1 x_P03,DISC03_T01_ - 1 z_P03,Sex_mat_ <= 0
liga_turno_P03,DISC03_T02,Ter_vesp_: 1 x_P03,DISC03_T02_ - 1 z_P03,Ter_vesp_ <= 0
liga_turno_P03,DISC03_T02,Qui_vesp_: 1 x_P03,DISC03_T02_ - 1 z_P03,Qui_vesp_ <= 0
liga_turno_P03,DISC03_T03,Seg_mat_: 1 x_P03,DISC03_T03_ - 1 z_P03,Seg_mat_ <= 0
liga_turno_P03,DISC03_T03,Ter_mat_: 1 x_P03,DISC03_T03_ - 1 z_P03,Ter_mat_ <= 0
liga_turno_P03,DISC04_T01,Ter_mat_: 1 x_P03,DISC04_T01_ - 1 z_P03,Ter_mat_ <= 0
liga_turno_P03,DISC04_T01,Qua_mat_: 1 x_P03,DISC04_T01_ - 1 z_P03,Qua_mat_ <= 0
liga_turno_P03,DISC04_T02,Ter_vesp_: 1 x_P03,DISC04_T02_ - 1 z_P03,Ter_vesp_ <= 0
liga_turno_P03,DISC04_T02,Qua_vesp_: 1 x_P03,DISC04_T02_ - 1 z_P03,Qua_vesp_ <= 0
liga_turno_P03,DISC04_T03,Seg_vesp_: 1 x_P03,DISC04_T03_ - 1 z_P03,Seg_vesp_ <= 0
liga_turno_P03,DISC04_T03,Qui_mat_: 1 x_P03,DISC04_T03_ - 1 z_P03,Qui_mat_ <= 0
liga_turno_P04,DISC01_T01,Ter_vesp_: 1 x_P04,DISC01_T01_ - 1 z_P04,Ter_vesp_ <= 0
liga_turno_P04,DISC01_T01,Qua_mat_: 1 x_P04,DISC01_T01_ - 1 z_P04,Qua_mat_ <= 0
liga_turno_P04,DISC01_T02,Seg_vesp_: 1 x_P04,DISC01_T02_ - 1 z_P04,Seg_vesp_ <= 0
liga_turno_P04,DISC01_T02,Sex_mat_: 1 x_P04,DISC01_T02_ - 1 z_P04,Sex_mat_ <= 0
liga_turno_P04,DISC01_T03,Seg_vesp_: 1 x_P04,DISC01_T03_ - 1 z_P04,Seg_vesp_ <= 0
liga_turno_P04,DISC01_T03,Sex_vesp_: 1 x_P04,DISC01_T03_ - 1 z_P04,Sex_vesp_ <= 0
liga_turno_P04,DISC02_T01,Seg_mat_: 1 x_P04,DISC02_T01_ - 1 z_P04,Seg_mat_ <= 0
liga_turno_P04,DISC02_T01,Qui_mat_: 1 x_P04,DISC02_T01_ - 1 z_P04,Qui_mat_ <= 0
liga_turno_P04,DISC02_T02,Seg_mat_: 1 x_P04,DISC02_T02_ - 1 z_P04,Seg_mat_ <= 0
liga_turno_P04,DISC02_T02,Sex_mat_: 1 x_P04,DISC02_T02_ - 1 z_P04,Sex_mat_ <= 0
liga_turno_P04,DISC02_T03,Ter_vesp_: 1 x_P04,DISC02_T03_ - 1 z_P04,Ter_vesp_ <= 0
liga_turno_P04,DISC02_T03,Sex_mat_: 1 x_P04,DISC02_T03_ - 1 z_P04,Sex_mat_ <= 0
liga_turno_P04,DISC03_T01,Qui_mat_: 1 x_P04,DISC03_T01_ - 1 z_P04,Qui_mat_ <= 0
liga_turno_P04,DISC03_T01,Sex_mat_: 1 x_P04,DISC03_T01_ - 1 z_P04,Sex_mat_ <= 0
liga_turno_P04,DISC03_T02,Ter_vesp_: 1 x_P04,DISC03_T02_ - 1 z_P04,Ter_vesp_ <= 0
liga_turno_P04,DISC03_T02,Qui_vesp_: 1 x_P04,DISC03_T02_ - 1 z_P04,Qui_vesp_ <= 0
liga_turno_P04,DISC03_T03,Seg_mat_: 1 x_P04,DISC03_T03_ - 1 z_P04,Seg_mat_ <= 0
liga_turno_P04,DISC03_T03,Ter_mat_: 1 x_P04,DISC03_T03_ - 1 z_P04,Ter_mat_ <= 0
liga_turno_P04,DISC04_T01,Ter_mat_: 1 x_P04,DISC04_T01_ - 1 z_P04,Ter_mat_ <= 0
liga_turno_P04,DISC04_T01,Qua_mat_: 1 x_P04,DISC04_T01_ - 1 z_P04,Qua_mat_ <= 0
liga_turno_P04,DISC04_T02,Ter_vesp_: 1 x_P04,DISC04_T02_ - 1 z_P04,Ter_vesp_ <= 0
liga_turno_P04,DISC04_T02,Qua_vesp_: 1 x_P04,DISC04_T02_ - 1 z_P04,Qua_vesp_ <= 0
liga_turno_P04,DISC04_T03,Seg_vesp_: 1 x_P04,DISC04_T03_ - 1 z_P04,Seg_vesp_ <= 0
liga_turno_P04,DISC04_T03,Qui_mat_: 1 x_P04,DISC04_T03_ - 1 z_P04,Qui_mat_ <= 0
liga_turno_P05,DISC01_T01,Ter_vesp_: 1 x_P05,DISC01_T01_ - 1 z_P05,Ter_vesp_ <= 0
liga_turno_P05,DISC01_T01,Qua_mat_: 1 x_P05,DISC01_T01_ - 1 z_P05,Qua_mat_ <= 0
liga_turno_P05,DISC01_T02,Seg_vesp_: 1 x_P05,DISC01_T02_ - 1 z_P05,Seg_vesp_ <= 0
liga_turno_P05,DISC01_T02,Sex_mat_: 1 x_P05,DISC01_T02_ - 1 z_P05,Sex_mat_ <= 0
liga_turno_P05,DISC01_T03,Seg_vesp_: 1 x_P05,DISC01_T03_ - 1 z_P05,Seg_vesp_ <= 0
liga_turno_P05,DISC01_T03,Sex_vesp_: 1 x_P05,DISC01_T03_ - 1 z_P05,Sex_vesp_ <= 0
liga_turno_P05,DISC02_T01,Seg_mat_: 1 x_P05,DISC02_T01_ - 1 z_P05,Seg_mat_ <= 0
liga_turno_P05,DISC02_T01,Qui_mat_: 1 x_P05,DISC02_T01_ - 1 z_P05,Qui_mat_ <= 0
liga_turno_P05,DISC02_T02,Seg_mat_: 1 x_P05,DISC02_T02_ - 1 z_P05,Seg_mat_ <= 0
liga_turno_P05,DISC02_T02,Sex_mat_: 1 x_P05,DISC02_T02_ - 1 z_P05,Sex_mat_ <= 0
liga_turno_P05,DISC02_T03,Ter_vesp_: 1 x_P05,DISC02_T03_ - 1 z_P05,Ter_vesp_ <= 0
liga_turno_P05,DISC02_T03,Sex_mat_: 1 x_P05,DISC02_T03_ - 1 z_P05,Sex_mat_ <= 0
liga_turno_P05,DISC03_T01,Qui_mat_: 1 x_P05,DISC03_T01_ - 1 z_P05,Qui_mat_ <= 0
liga_turno_P05,DISC03_T01,Sex_mat_: 1 x_P05,DISC03_T01_ - 1 z_P05,Sex_mat_ <= 0
liga_turno_P05,DISC03_T02,Ter_vesp_: 1 x_P05,DISC03_T02_ - 1 z_P05,Ter_vesp_ <= 0
liga_turno_P05,DISC03_T02,Qui_vesp_: 1 x_P05,DISC03_T02_ - 1 z_P05,Qui_vesp_ <= 0
liga_turno_P05,DISC03_T03,Seg_mat_: 1 x_P05,DISC03_T03_ - 1 z_P05,Seg_mat_ <= 0
liga_turno_P05,DISC03_T03,Ter_mat_: 1 x_P05,DISC03_T03_ - 1 z_P05,Ter_mat_ <= 0
liga_turno_P05,DISC04_T01,Ter_mat_: 1 x_P05,DISC04_T01_ - 1 z_P05,Ter_mat_ <= 0
liga_turno_P05,DISC04_T01,Qua_mat_: 1 x_P05,DISC04_T01_ - 1 z_P05,Qua_mat_ <= 0
liga_turno_P05,DISC04_T02,Ter_vesp_: 1 x_P05,DISC04_T02_ - 1 z_P05,Ter_vesp_ <= 0
liga_turno_P05,DISC04_T02,Qua_vesp_: 1 x_P05,DISC04_T02_ - 1 z_P05,Qua_vesp_ <= 0
liga_turno_P05,DISC04_T03,Seg_vesp_: 1 x_P05,DISC04_T03_ - 1 z_P05,Seg_vesp_ <= 0
liga_turno_P05,DISC04_T03,Qui_mat_: 1 x_P05,DISC04_T03_ - 1 z_P05,Qui_mat_ <= 0
liga_turno_P06,DISC01_T01,Ter_vesp_: 1 x_P06,DISC01_T01_ - 1 z_P06,Ter_vesp_ <= 0
liga_turno_P06,DISC01_T01,Qua_mat_: 1 x_P06,DISC01_T01_ - 1 z_P06,Qua_mat_ <= 0
liga_turno_P06,DISC01_T02,Seg_vesp_: 1 x_P06,DISC01_T02_ - 1 z_P06,Seg_vesp_ <= 0
liga_turno_P06,DISC01_T02,Sex_mat_: 1 x_P06,DISC01_T02_ - 1 z_P06,Sex_mat_ <= 0
liga_turno_P06,DISC01_T03,Seg_vesp_: 1 x_P06,DISC01_T03_ - 1 z_P06,Seg_vesp_ <= 0
liga_turno_P06,DISC01_T03,Sex_vesp_: 1 x_P06,DISC01_T03_ - 1 z_P06,Sex_vesp_ <= 0
liga_turno_P06,DISC02_T01,Seg_mat_: 1 x_P06,DISC02_T01_ - 1 z_P06,Seg_mat_ <= 0
liga_turno_P06,DISC02_T01,Qui_mat_: 1 x_P06,DISC02_T01_ - 1 z_P06,Qui_mat_ <= 0
liga_turno_P06,DISC02_T02,Seg_mat_: 1 x_P06,DISC02_T02_ - 1 z_P06,Seg_mat_ <= 0
liga_turno_P06,DISC02_T02,Sex_mat_: 1 x_P06,DISC02_T02_ - 1 z_P06,Sex_mat_ <= 0
liga_turno_P06,DISC02_T03,Ter_vesp_: 1 x_P06,DISC02_T03_ - 1 z_P06,Ter_vesp_ <= 0
liga_turno_P06,DISC02_T03,Sex_mat_: 1 x_P06,DISC02_T03_ - 1 z_P06,Sex_mat_ <= 0
liga_turno_P06,DISC03_T01,Qui_mat_: 1 x_P06,DISC03_T01_ - 1 z_P06,Qui_mat_ <= 0
liga_turno_P06,DISC03_T01,Sex_mat_: 1 x_P06,DISC03_T01_ - 1 z_P06,Sex_mat_ <= 0
liga_turno_P06,DISC03_T02,Ter_vesp_: 1 x_P06,DISC03_T02_ - 1 z_P06,Ter_vesp_ <= 0
liga_turno_P06,DISC03_T02,Qui_vesp_: 1 x_P06,DISC03_T02_ - 1 z_P06,Qui_vesp_ <= 0
liga_turno_P06,DISC03_T03,Seg_mat_: 1 x_P06,DISC03_T03_ - 1 z_P06,Seg_mat_ <= 0
liga_turno_P06,DISC03_T03,Ter_mat_: 1 x_P06,DISC03_T03_ - 1 z_P06,Ter_mat_ <= 0
liga_turno_P06,DISC04_T01,Ter_mat_: 1 x_P06,DISC04_T01_ - 1 z_P06,Ter_mat_ <= 0
liga_turno_P06,DISC04_T01,Qua_mat_: 1 x_P06,DISC04_T01_ - 1 z_P06,Qua_mat_ <= 0
liga_turno_P06,DISC04_T02,Ter_vesp_: 1 x_P06,DISC04_T02_ - 1 z_P06,Ter_vesp_ <= 0
liga_turno_P06,DISC04_T02,Qua_vesp_: 1 x_P06,DISC04_T02_ - 1 z_P06,Qua_vesp_ <= 0
liga_turno_P06,DISC04_T03,Seg_vesp_: 1 x_P06,DISC04_T03_ - 1 z_P06,Seg_vesp_ <= 0
liga_turno_P06,DISC04_T03,Qui_mat_: 1 x_P06,DISC04_T03_ - 1 z_P06,Qui_mat_ <= 0
liga_turno_reversa_P01,Seg_mat_: -1 x_P01,DISC02_T01_ - 1 x_P01,DISC02_T02_ - 1 x_P01,DISC03_T03_ + 1 z_P01,Seg_mat_ <= 0
liga_turno_reversa_P02,Seg_mat_: -1 x_P02,DISC02_T01_ - 1 x_P02,DISC02_T02_ - 1 x_P02,DISC03_T03_ + 1 z_P02,Seg_mat_ <= 0
liga_turno_reversa_P03,Seg_mat_: -1 x_P03,DISC02_T01_ - 1 x_P03,DISC02_T02_ - 1 x_P03,DISC03_T03_ + 1 z_P03,Seg_mat_ <= 0
liga_turno_reversa_P04,Seg_mat_: -1 x_P04,DISC02_T01_ - 1 x_P04,DISC02_T02_ - 1 x_P04,DISC03_T03_ + 1 z_P04,Seg_mat_ <= 0
liga_turno_reversa_P05,Seg_mat_: -1 x_P05,DISC02_T01_ - 1 x_P05,DISC02_T02_ - 1 x_P05,DISC03_T03_ + 1 z_P05,Seg_mat_ <= 0
liga_turno_reversa_P06,Seg_mat_: -1 x_P06,DISC02_T01_ - 1 x_P06,DISC02_T02_ - 1 x_P06,DISC03_T03_ + 1 z_P06,Seg_mat_ <= 0
liga_turno_reversa_P01,Seg_vesp_: -1 x_P01,DISC01_T02_ - 1 x_P01,DISC01_T03_ - 1 x_P01,DISC04_T03_ + 1 z_P01,Seg_vesp_ <= 0
liga_turno_reversa_P02,Seg_vesp_: -1 x_P02,DISC01_T02_ - 1 x_P02,DISC01_T03_ - 1 x_P02,DISC04_T03_ + 1 z_P02,Seg_vesp_ <= 0
liga_turno_reversa_P03,Seg_vesp_: -1 x_P03,DISC01_T02_ - 1 x_P03,DISC01_T03_ - 1 x_P03,DISC04_T03_ + 1 z_P03,Seg_vesp_ <= 0
liga_turno_reversa_P04,Seg_vesp_: -1 x_P04,DISC01_T02_ - 1 x_P04,DISC01_T03_ - 1 x_P04,DISC04_T03_ + 1 z_P04,Seg_vesp_ <= 0
liga_turno_reversa_P05,Seg_vesp_: -1 x_P05,DISC01_T02_ - 1 x_P05,DISC01_T03_ - 1 x_P05,DISC04_T03_ + 1 z_P05,Seg_vesp_ <= 0
liga_turno_reversa_P06,Seg_vesp_: -1 x_P06,DISC01_T02_ - 1 x_P06,DISC01_T03_ - 1 x_P06,DISC04_T03_ + 1 z_P06,Seg_vesp_ <= 0
liga_turno_reversa_P01,Ter_mat_: -1 x_P01,DISC03_T03_ - 1 x_P01,DISC04_T01_ + 1 z_P01,Ter_mat_ <= 0
liga_turno_reversa_P02,Ter_mat_: -1 x_P02,DISC03_T03_ - 1 x_P02,DISC04_T01_ + 1 z_P02,Ter_mat_ <= 0
liga_turno_reversa_P03,Ter_mat_: -1 x_P03,DISC03_T03_ - 1 x_P03,DISC04_T01_ + 1 z_P03,Ter_mat_ <= 0
liga_turno_reversa_P04,Ter_mat_: -1 x_P04,DISC03_T03_ - 1 x_P04,DISC04_T01_ + 1 z_P04,Ter_mat_ <= 0
liga_turno_reversa_P05,Ter_mat_: -1 x_P05,DISC03_T03_ - 1 x_P05,DISC04_T01_ + 1 z_P05,Ter_mat_ <= 0
liga_turno_reversa_P06,Ter_mat_: -1 x_P06,DISC03_T03_ - 1 x_P06,DISC04_T01_ + 1 z_P06,Ter_mat_ <= 0
liga_turno_reversa_P01,Ter_vesp_: -1 x_P01,DISC01_T01_ - 1 x_P01,DISC02_T03_ - 1 x_P01,DISC03_T02_ - 1 x_P01,DISC04_T02_ + 1 z_P01,Ter_vesp_ <= 0
liga_turno_reversa_P02,Ter_vesp_: -1 x_P02,DISC01_T01_ - 1 x_P02,DISC02_T03_ - 1 x_P02,DISC03_T02_ - 1 x_P02,DISC04_T02_ + 1 z_P02,Ter_vesp_ <= 0
liga_turno_reversa_P03,Ter_vesp_: -1 x_P03,DISC01_T01_ - 1 x_P03,DISC02_T03_ - 1 x_P03,DISC03_T02_ - 1 x_P03,DISC04_T02_ + 1 z_P03,Ter_vesp_ <= 0
liga_turno_reversa_P04,Ter_vesp_: -1 x_P04,DISC01_T01_ - 1 x_P04,DISC02_T03_ - 1 x_P04,DISC03_T02_ - 1 x_P04,DISC04_T02_ + 1 z_P04,Ter_vesp_ <= 0
liga_turno_reversa_P05,Ter_vesp_: -1 x_P05,DISC01_T01_ - 1 x_P05,DISC02_T03_ - 1 x_P05,DISC03_T02_ - 1 x_P05,DISC04_T02_ + 1 z_P05,Ter_vesp_ <= 0
liga_turno_reversa_P06,Ter_vesp_: -1 x_P06,DISC01_T01_ - 1 x_P06,DISC02_T03_ - 1 x_P06,DISC03_T02_ - 1 x_P06,DISC04_T02_ + 1 z_P06,Ter_vesp_ <= 0
liga_turno_reversa_P01,Qua_mat_: -1 x_P01,DISC01_T01_ - 1 x_P01,DISC04_T01_ + 1 z_P01,Qua_mat_ <= 0
liga_turno_reversa_P02,Qua_mat_: -1 x_P02,DISC01_T01_ - 1 x_P02,DISC04_T01_ + 1 z_P02,Qua_mat_ <= 0
liga_turno_reversa_P03,Qua_mat_: -1 x_P03,DISC01_T01_ - 1 x_P03,DISC04_T01_ + 1 z_P03,Qua_mat_ <= 0
liga_turno_reversa_P04,Qua_mat_: -1 x_P04,DISC01_T01_ - 1 x_P04,DISC04_T01_ + 1 z_P04,Qua_mat_ <= 0
liga_turno_reversa_P05,Qua_mat_: -1 x_P05,DISC01_T01_ - 1 x_P05,DISC04_T01_ + 1 z_P05,Qua_mat_ <= 0
liga_turno_reversa_P06,Qua_mat_: -1 x_P06,DISC01_T01_ - 1 x_P06,DISC04_T01_ + 1 z_P06,Qua_mat_ <= 0
liga_turno_reversa_P01,Qua_vesp_: -1 x_P01,DISC04_T02_ + 1 z_P01,Qua_vesp_ <= 0
liga_turno_reversa_P02,Qua_vesp_: -1 x_P02,DISC04_T02_ + 1 z_P02,Qua_vesp_ <= 0
liga_turno_reversa_P03,Qua_vesp_: -1 x_P03,DISC04_T02_ + 1 z_P03,Qua_vesp_ <= 0
liga_turno_reversa_P04,Qua_vesp_: -1 x_P04,DISC04_T02_ + 1 z_P04,Qua_vesp_ <= 0
liga_turno_reversa_P05,Qua_vesp_: -1 x_P05,DISC04_T02_ + 1 z_P05,Qua_vesp_ <= 0
liga_turno_reversa_P06,Qua_vesp_: -1 x_P06,DISC04_T02_ + 1 z_P06,Qua_vesp_ <= 0
liga_turno_reversa_P01,Qui_mat_: -1 x_P01,DISC02_T01_ - 1 x_P01,DISC03_T01_ - 1 x_P01,DISC04_T03_ + 1 z_P01,Qui_mat_ <= 0
liga_turno_reversa_P02,Qui_mat_: -1 x_P02,DISC02_T01_ - 1 x_P02,DISC03_T01_ - 1 x_P02,DISC04_T03_ + 1 z_P02,Qui_mat_ <= 0
liga_turno_reversa_P03,Qui_mat_: -1 x_P03,DISC02_T01_ - 1 x_P03,DISC03_T01_ - 1 x_P03,DISC04_T03_ + 1 z_P03,Qui_mat_ <= 0
liga_turno_reversa_P04,Qui_mat_: -1 x_P04,DISC02_T01_ - 1 x_P04,DISC03_T01_ - 1 x_P04,DISC04_T03_ + 1 z_P04,Qui_mat_ <= 0
liga_turno_reversa_P05,Qui_mat_: -1 x_P05,DISC02_T01_ - 1 x_P05,DISC03_T01_ - 1 x_P05,DISC04_T03_ + 1 z_P05,Qui_mat_ <= 0
liga_turno_reversa_P06,Qui_mat_: -1 x_P06,DISC02_T01_ - 1 x_P06,DISC03_T01_ - 1 x_P06,DISC04_T03_ + 1 z_P06,Qui_mat_ <= 0
liga_turno_reversa_P01,Qui_vesp_: -1 x_P01,DISC03_T02_ + 1 z_P01,Qui_vesp_ <= 0
liga_turno_reversa_P02,Qui_vesp_: -1 x_P02,DISC03_T02_ + 1 z_P02,Qui_vesp_ <= 0
liga_turno_reversa_P03,Qui_vesp_: -1 x_P03,DISC03_T02_ + 1 z_P03,Qui_vesp_ <= 0
liga_turno_reversa_P04,Qui_vesp_: -1 x_P04,DISC03_T02_ + 1 z_P04,Qui_vesp_ <= 0
liga_turno_reversa_P05,Qui_vesp_: -1 x_P05,DISC03_T02_ + 1 z_P05,Qui_vesp_ <= 0
liga_turno_reversa_P06,Qui_vesp_: -1 x_P06,DISC03_T02_ + 1 z_P06,Qui_vesp_ <= 0
liga_turno_reversa_P01,Sex_mat_: -1 x_P01,DISC01_T02_ - 1 x_P01,DISC02_T02_ - 1 x_P01,DISC02_T03_ - 1 x_P01,DISC03_T01_ + 1 z_P01,Sex_mat_ <= 0
liga_turno_reversa_P02,Sex_mat_: -1 x_P02,DISC01_T02_ - 1 x_P02,DISC02_T02_ - 1 x_P02,DISC02_T03_ - 1 x_P02,DISC03_T01_ + 1 z_P02,Sex_mat_ <= 0
liga_turno_reversa_P03,Sex_mat_: -1 x_P03,DISC01_T02_ - 1 x_P03,DISC02_T02_ - 1 x_P03,DISC02_T03_ - 1 x_P03,DISC03_T01_ + 1 z_P03,Sex_mat_ <= 0
liga_turno_reversa_P04,Sex_mat_: -1 x_P04,DISC01_T02_ - 1 x_P04,DISC02_T02_ - 1 x_P04,DISC02_T03_ - 1 x_P04,DISC03_T01_ + 1 z_P04,Sex_mat_ <= 0
liga_turno_reversa_P05,Sex_mat_: -1 x_P05,DISC01_T02_ - 1 x_P05,DISC02_T02_ - 1 x_P05,DISC02_T03_ - 1 x_P05,DISC03_T01_ + 1 z_P05,Sex_mat_ <= 0
liga_turno_reversa_P06,Sex_mat_: -1 x_P06,DISC01_T02_ - 1 x_P06,DISC02_T02_ - 1 x_P06,DISC02_T03_ - 1 x_P06,DISC03_T01_ + 1 z_P06,Sex_mat_ <= 0
liga_turno_reversa_P01,Sex_vesp_: -1 x_P01,DISC01_T03_ + 1 z_P01,Sex_vesp_ <= 0
liga_turno_reversa_P02,Sex_vesp_: -1 x_P02,DISC01_T03_ + 1 z_P02,Sex_vesp_ <= 0
liga_turno_reversa_P03,Sex_vesp_: -1 x_P03,DISC01_T03_ + 1 z_P03,Sex_vesp_ <= 0
liga_turno_reversa_P04,Sex_vesp_: -1 x_P04,DISC01_T03_ + 1 z_P04,Sex_vesp_ <= 0
liga_turno_reversa_P05,Sex_vesp_: -1 x_P05,DISC01_T03_ + 1 z_P05,Sex_vesp_ <= 0
liga_turno_reversa_P06,Sex_vesp_: -1 x_P06,DISC01_T03_ + 1 z_P06,Sex_vesp_ <= 0
carga_min_P01_: 4 x_P01,DISC01_T01_ + 4 x_P01,DISC01_T02_ + 4 x_P01,DISC01_T03_ + 4 x_P01,DISC02_T01_ + 4 x_P01,DISC02_T02_ + 4 x_P01,DISC02_T03_ + 4 x_P01,DISC03_T01_ + 4 x_P01,DISC03_T02_ + 4 x_P01,DISC03_T03_ + 4 x_P01,DISC04_T01_ + 4 x_P01,DISC04_T02_ + 4 x_P01,DISC04_T03_ >= 6
carga_min_P02_: 4 x_P02,DISC01_T01_ + 4 x_P02,DISC01_T02_ + 4 x_P02,DISC01_T03_ + 4 x_P02,DISC02_T01_ + 4 x_P02,DISC02_T02_ + 4 x_P02,DISC02_T03_ + 4 x_P02,DISC03_T01_ + 4 x_P02,DISC03_T02_ + 4 x_P02,DISC03_T03_ + 4 x_P02,DISC04_T01_ + 4 x_P02,DISC04_T02_ + 4 x_P02,DISC04_T03_ >= 6
carga_min_P03_: 4 x_P03,DISC01_T01_ + 4 x_P03,DISC01_T02_ + 4 x_P03,DISC01_T03_ + 4 x_P03,DISC02_T01_ + 4 x_P03,DISC02_T02_ + 4 x_P03,DISC02_T03_ + 4 x_P03,DISC03_T01_ + 4 x_P03,DISC03_T02_ + 4 x_P03,DISC03_T03_ + 4 x_P03,DISC04_T01_ + 4 x_P03,DISC04_T02_ + 4 x_P03,DISC04_T03_ >= 6
carga_min_P04_: 4 x_P04,DISC01_T01_ + 4 x_P04,DISC01_T02_ + 4 x_P04,DISC01_T03_ + 4 x_P04,DISC02_T01_ + 4 x_P04,DISC02_T02_ + 4 x_P04,DISC02_T03_ + 4 x_P04,DISC03_T01_ + 4 x_P04,DISC03_T02_ + 4 x_P04,DISC03_T03_ + 4 x_P04,DISC04_T01_ + 4 x_P04,DISC04_T02_ + 4 x_P04,DISC04_T03_ >= 6
carga_min_P05_: 4 x_P05,DISC01_T01_ + 4 x_P05,DISC01_T02_ + 4 x_P05,DISC01_T03_ + 4 x_P05,DISC02_T01_ + 4 x_P05,DISC02_T02_ + 4 x_P05,DISC02_T03_ + 4 x_P05,DISC03_T01_ + 4 x_P05,DISC03_T02_ + 4 x_P05,DISC03_T03_ + 4 x_P05,DISC04_T01_ + 4 x_P05,DISC04_T02_ + 4 x_P05,DISC04_T03_ >= 6
carga_min_P06_: 4 x_P06,DISC01_T01_ + 4 x_P06,DISC01_T02_ + 4 x_P06,DISC01_T03_ + 4 x_P06,DISC02_T01_ + 4 x_P06,DISC02_T02_ + 4 x_P06,DISC02_T03_ + 4 x_P06,DISC03_T01_ + 4 x_P06,DISC03_T02_ + 4 x_P06,DISC03_T03_ + 4 x_P06,DISC04_T01_ + 4 x_P06,DISC04_T02_ + 4 x_P06,DISC04_T03_ >= 6
teto_disciplinas_P01_: -1 g_P01,DISC01_ - 1 g_P01,DISC02_ - 1 g_P01,DISC03_ - 1 g_P01,DISC04_ + 1 g_max >= 0
teto_disciplinas_P02_: -1 g_P02,DISC01_ - 1 g_P02,DISC02_ - 1 g_P02,DISC03_ - 1 g_P02,DISC04_ + 1 g_max >= 0
teto_disciplinas_P03_: -1 g_P03,DISC01_ - 1 g_P03,DISC02_ - 1 g_P03,DISC03_ - 1 g_P03,DISC04_ + 1 g_max >= 0
teto_disciplinas_P04_: -1 g_P04,DISC01_ - 1 g_P04,DISC02_ - 1 g_P04,DISC03_ - 1 g_P04,DISC04_ + 1 g_max >= 0
teto_disciplinas_P05_: -1 g_P05,DISC01_ - 1 g_P05,DISC02_ - 1 g_P05,DISC03_ - 1 g_P05,DISC04_ + 1 g_max >= 0
teto_disciplinas_P06_: -1 g_P06,DISC01_ - 1 g_P06,DISC02_ - 1 g_P06,DISC03_ - 1 g_P06,DISC04_ + 1 g_max >= 0
cobertura_DISC01_T01_: 1 x_P01,DISC01_T01_ + 1 x_P02,DISC01_T01_ + 1 x_P03,DISC01_T01_ + 1 x_P04,DISC01_T01_ + 1 x_P05,DISC01_T01_ + 1 x_P06,DISC01_T01_ = 1
cobertura_DISC01_T02_: 1 x_P01,DISC01_T02_ + 1 x_P02,DISC01_T02_ + 1 x_P03,DISC01_T02_ + 1 x_P04,DISC01_T02_ + 1 x_P05,DISC01_T02_ + 1 x_P06,DISC01_T02_ = 1
cobertura_DISC01_T03_: 1 x_P01,DISC01_T03_ + 1 x_P02,DISC01_T03_ + 1 x_P03,DISC01_T03_ + 1 x_P04,DISC01_T03_ + 1 x_P05,DISC01_T03_ + 1 x_P06,DISC01_T03_ = 1
cobertura_DISC02_T01_: 1 x_P01,DISC02_T01_ + 1 x_P02,DISC02_T01_ + 1 x_P03,DISC02_T01_ + 1 x_P04,DISC02_T01_ + 1 x_P05,DISC02_T01_ + 1 x_P06,DISC02_T01_ = 1
cobertura_DISC02_T02_: 1 x_P01,DISC02_T02_ + 1 x_P02,DISC02_T02_ + 1 x_P03,DISC02_T02_ + 1 x_P04,DISC02_T02_ + 1 x_P05,DISC02_T02_ + 1 x_P06,DISC02_T02_ = 1
cobertura_DISC02_T03_: 1 x_P01,DISC02_T03_ + 1 x_P02,DISC02_T03_ + 1 x_P03,DISC02_T03_ + 1 x_P04,DISC02_T03_ + 1 x_P05,DISC02_T03_ + 1 x_P06,DISC02_T03_ = 1
cobertura_DISC03_T01_: 1 x_P01,DISC03_T01_ + 1 x_P02,DISC03_T01_ + 1 x_P03,DISC03_T01_ + 1 x_P04,DISC03_T01_ + 1 x_P05,DISC03_T01_ + 1 x_P06,DISC03_T01_ = 1
cobertura_DISC03_T02_: 1 x_P01,DISC03_T02_ + 1 x_P02,DISC03_T02_ + 1 x_P03,DISC03_T02_ + 1 x_P04,DISC03_T02_ + 1 x_P05,DISC03_T02_ + 1 x_P06,DISC03_T02_ = 1
cobertura_DISC03_T03_: 1 x_P01,DISC03_T03_ + 1 x_P02,DISC03_T03_ + 1 x_P03,DISC03_T03_ + 1 x_P04,DISC03_T03_ + 1 x_P05,DISC03_T03_ + 1 x_P06,DISC03_T03_ = 1
cobertura_DISC04_T01_: 1 x_P01,DISC04_T01_ + 1 x_P02,DISC04_T01_ + 1 x_P03,DISC04_T01_ + 1 x_P04,DISC04_T01_ + 1 x_P05,DISC04_T01_ + 1 x_P06,DISC04_T01_ = 1
cobertura_DISC04_T02_: 1 x_P01,DISC04_T02_ + 1 x_P02,DISC04_T02_ + 1 x_P03,DISC04_T02_ + 1 x_P04,DISC04_T02_ + 1 x_P05,DISC04_T02_ + 1 x_P06,DISC04_T02_ = 1
cobertura_DISC04_T03_: 1 x_P01,DISC04_T03_ + 1 x_P02,DISC04_T03_ + 1 x_P03,DISC04_T03_ + 1 x_P04,DISC04_T03_ + 1 x_P05,DISC04_T03_ + 1 x_P06,DISC04_T03_ = 1
Bounds
s_min >= 0
g_max >= 0
General
s_min
g_max
Binary
x_P01,DISC01_T01_
x_P02,DISC01_T01_
x_P03,DISC01_T01_
x_P04,DISC01_T01_
x_P05,DISC01_T01_
x_P06,DISC01_T01_
x_P01,DISC01_T02_
x_P02,DISC01_T02_
x_P03,DISC01_T02_
x_P04,DISC01_T02_
x_P05,DISC01_T02_
x_P06,DISC01_T02_
x_P01,DISC01_T03_
x_P02,DISC01_T03_
x_P03,DISC01_T03_
x_P04,DISC01_T03_
x_P05,DISC01_T03_
x_P06,DISC01_T03_
x_P01,DISC02_T01_
x_P02,DISC02_T01_
x_P03,DISC02_T01_
x_P04,DISC02_T01_
x_P05,DISC02_T01_
x_P06,DISC02_T01_
x_P01,DISC02_T02_
x_P02,DISC02_T02_
x_P03,DISC02_T02_
x_P04,DISC02_T02_
x_P05,DISC02_T02_
x_P06,DISC02_T02_
x_P01,DISC02_T03_
x_P02,DISC02_T03_
x_P03,DISC02_T03_
x_P04,DISC02_T03_
x_P05,DISC02_T03_
x_P06,DISC02_T03_
x_P01,DISC03_T01_
x_P02,DISC03_T01_
x_P03,DISC03_T01_
x_P04,DISC03_T01_
x_P05,DISC03_T01_
x_P06,DISC03_T01_
x_P01,DISC03_T02_
x_P02,DISC03_T02_
x_P03,DISC03_T02_
x_P04,DISC03_T02_
x_P05,DISC03_T02_
x_P06,DISC03_T02_
x_P01,DISC03_T03_
x_P02,DISC03_T03_
x_P03,DISC03_T03_
x_P04,DISC03_T03_
x_P05,DISC03_T03_
x_P06,DISC03_T03_
x_P01,DISC04_T01_
x_P02,DISC04_T01_
x_P03,DISC04_T01_
x_P04,DISC04_T01_
x_P05,DISC04_T01_
x_P06,DISC04_T01_
x_P01,DISC04_T02_
x_P02,DISC04_T02_
x_P03,DISC04_T02_
x_P04,DISC04_T02_
x_P05,DISC04_T02_
x_P06,DISC04_T02_
x_P01,DISC04_T03_
x_P02,DISC04_T03_
x_P03,DISC04_T03_
x_P04,DISC04_T03_
x_P05,DISC04_T03_
x_P06,DISC04_T03_
z_P01,Seg_mat_
z_P02,Seg_mat_
z_P03,Seg_mat_
z_P04,Seg_mat_
z_P05,Seg_mat_
z_P06,Seg_mat_
z_P01,Seg_vesp_
z_P02,Seg_vesp_
z_P03,Seg_vesp_
z_P04,Seg_vesp_
z_P05,Seg_vesp_
z_P06,Seg_vesp_
z_P01,Ter_mat_
z_P02,Ter_mat_
z_P03,Ter_mat_
z_P04,Ter_mat_
z_P05,Ter_mat_
z_P06,Ter_mat_
z_P01,Ter_vesp_
z_P02,Ter_vesp_
z_P03,Ter_vesp_
z_P04,Ter_vesp_
z_P05,Ter_vesp_
z_P06,Ter_vesp_
z_P01,Qua_mat_
z_P02,Qua_mat_
z_P03,Qua_mat_
z_P04,Qua_mat_
z_P05,Qua_mat_
z_P06,Qua_mat_
z_P01,Qua_vesp_
z_P02,Qua_vesp_
z_P03,Qua_vesp_
z_P04,Qua_vesp_
z_P05,Qua_vesp_
z_P06,Qua_vesp_
z_P01,Qui_mat_
z_P02,Qui_mat_
z_P03,Qui_mat_
z_P04,Qui_mat_
z_P05,Qui_mat_
z_P06,Qui_mat_
z_P01,Qui_vesp_
z_P02,Qui_vesp_
z_P03,Qui_vesp_
z_P04,Qui_vesp_
z_P05,Qui_vesp_
z_P06,Qui_vesp_
z_P01,Sex_mat_
z_P02,Sex_mat_
z_P03,Sex_mat_
z_P04,Sex_mat_
z_P05,Sex_mat_
z_P06,Sex_mat_
z_P01,Sex_vesp_
z_P02,Sex_vesp_
z_P03,Sex_vesp_
z_P04,Sex_vesp_
z_P05,Sex_vesp_
z_P06,Sex_vesp_
g_P01,DISC01_
g_P02,DISC01_
g_P03,DISC01_
g_P04,DISC01_
g_P05,DISC01_
g_P06,DISC01_
g_P01,DISC02_
g_P02,DISC02_
g_P03,DISC02_
g_P04,DISC02_
g_P05,DISC02_
g_P06,DISC02_
g_P01,DISC03_
g_P02,DISC03_
g_P03,DISC03_
g_P04,DISC03_
g_P05,DISC03_
g_P06,DISC03_
g_P01,DISC04_
g_P02,DISC04_
g_P03,DISC04_
g_P04,DISC04_
g_P05,DISC04_
g_P06,DISC04_
End
