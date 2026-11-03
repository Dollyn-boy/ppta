maximize
obj: 2.4 x_P01,EXA806_T01_ + 3 x_P01,EXA806_T02_ + 2.4 x_P02,EXA806_T02_ + 1.7999999999999998 x_P02,TEC217_TP02_ + 3 x_P03,TEC217_TP01_ + 0.6 x_P03,TEC217_TP02_ + 0.2 s_min - 0.1 z_P01,Seg_vesp_ - 0.1 z_P01,Ter_mat_ - 0.1 z_P01,Ter_vesp_ - 0.1 z_P01,Qua_vesp_ - 0.1 z_P01,Qui_mat_ - 0.1 z_P01,Qui_vesp_ - 0.1 z_P02,Seg_vesp_ - 0.1 z_P02,Ter_mat_ - 0.1 z_P02,Ter_vesp_ - 0.1 z_P02,Qua_vesp_ - 0.1 z_P02,Qui_mat_ - 0.1 z_P02,Qui_vesp_ - 0.1 z_P03,Seg_vesp_ - 0.1 z_P03,Ter_mat_ - 0.1 z_P03,Ter_vesp_ - 0.1 z_P03,Qua_vesp_ - 0.1 z_P03,Qui_mat_ - 0.1 z_P03,Qui_vesp_ - 0.1 g_max
subject to
_elegibilidade_P01,EXA806_T01_: 1 x_P01,EXA806_T01_ <= 1
_elegibilidade_P02,EXA806_T01_: 1 x_P02,EXA806_T01_ <= 0
_elegibilidade_P03,EXA806_T01_: 1 x_P03,EXA806_T01_ <= 0
_elegibilidade_P01,EXA806_T02_: 1 x_P01,EXA806_T02_ <= 1
_elegibilidade_P02,EXA806_T02_: 1 x_P02,EXA806_T02_ <= 1
_elegibilidade_P03,EXA806_T02_: 1 x_P03,EXA806_T02_ <= 0
_elegibilidade_P01,TEC217_TP01_: 1 x_P01,TEC217_TP01_ <= 0
_elegibilidade_P02,TEC217_TP01_: 1 x_P02,TEC217_TP01_ <= 0
_elegibilidade_P03,TEC217_TP01_: 1 x_P03,TEC217_TP01_ <= 1
_elegibilidade_P01,TEC217_TP02_: 1 x_P01,TEC217_TP02_ <= 0
_elegibilidade_P02,TEC217_TP02_: 1 x_P02,TEC217_TP02_ <= 1
_elegibilidade_P03,TEC217_TP02_: 1 x_P03,TEC217_TP02_ <= 1
carga_max_P01_: 4 x_P01,EXA806_T01_ + 4 x_P01,EXA806_T02_ + 4 x_P01,TEC217_TP01_ + 4 x_P01,TEC217_TP02_ <= 12
carga_max_P02_: 4 x_P02,EXA806_T01_ + 4 x_P02,EXA806_T02_ + 4 x_P02,TEC217_TP01_ + 4 x_P02,TEC217_TP02_ <= 12
carga_max_P03_: 4 x_P03,EXA806_T01_ + 4 x_P03,EXA806_T02_ + 4 x_P03,TEC217_TP01_ + 4 x_P03,TEC217_TP02_ <= 12
piso_satisfacao_P01_: -4 x_P01,EXA806_T01_ - 5 x_P01,EXA806_T02_ + 1 s_min <= 0
piso_satisfacao_P02_: -4 x_P02,EXA806_T02_ - 3 x_P02,TEC217_TP02_ + 1 s_min <= 0
piso_satisfacao_P03_: -5 x_P03,TEC217_TP01_ - 1 x_P03,TEC217_TP02_ + 1 s_min <= 0
liga_disciplina_P01,EXA806_T01_: 1 x_P01,EXA806_T01_ - 1 g_P01,EXA806_ <= 0
liga_disciplina_P02,EXA806_T01_: 1 x_P02,EXA806_T01_ - 1 g_P02,EXA806_ <= 0
liga_disciplina_P03,EXA806_T01_: 1 x_P03,EXA806_T01_ - 1 g_P03,EXA806_ <= 0
liga_disciplina_P01,EXA806_T02_: 1 x_P01,EXA806_T02_ - 1 g_P01,EXA806_ <= 0
liga_disciplina_P02,EXA806_T02_: 1 x_P02,EXA806_T02_ - 1 g_P02,EXA806_ <= 0
liga_disciplina_P03,EXA806_T02_: 1 x_P03,EXA806_T02_ - 1 g_P03,EXA806_ <= 0
liga_disciplina_P01,TEC217_TP01_: 1 x_P01,TEC217_TP01_ - 1 g_P01,TEC217_ <= 0
liga_disciplina_P02,TEC217_TP01_: 1 x_P02,TEC217_TP01_ - 1 g_P02,TEC217_ <= 0
liga_disciplina_P03,TEC217_TP01_: 1 x_P03,TEC217_TP01_ - 1 g_P03,TEC217_ <= 0
liga_disciplina_P01,TEC217_TP02_: 1 x_P01,TEC217_TP02_ - 1 g_P01,TEC217_ <= 0
liga_disciplina_P02,TEC217_TP02_: 1 x_P02,TEC217_TP02_ - 1 g_P02,TEC217_ <= 0
liga_disciplina_P03,TEC217_TP02_: 1 x_P03,TEC217_TP02_ - 1 g_P03,TEC217_ <= 0
liga_disciplina_reversa_P01,EXA806_: -1 x_P01,EXA806_T01_ - 1 x_P01,EXA806_T02_ + 1 g_P01,EXA806_ <= 0
liga_disciplina_reversa_P02,EXA806_: -1 x_P02,EXA806_T01_ - 1 x_P02,EXA806_T02_ + 1 g_P02,EXA806_ <= 0
liga_disciplina_reversa_P03,EXA806_: -1 x_P03,EXA806_T01_ - 1 x_P03,EXA806_T02_ + 1 g_P03,EXA806_ <= 0
liga_disciplina_reversa_P01,TEC217_: -1 x_P01,TEC217_TP01_ - 1 x_P01,TEC217_TP02_ + 1 g_P01,TEC217_ <= 0
liga_disciplina_reversa_P02,TEC217_: -1 x_P02,TEC217_TP01_ - 1 x_P02,TEC217_TP02_ + 1 g_P02,TEC217_ <= 0
liga_disciplina_reversa_P03,TEC217_: -1 x_P03,TEC217_TP01_ - 1 x_P03,TEC217_TP02_ + 1 g_P03,TEC217_ <= 0
liga_turno_P01,EXA806_T01,Seg_vesp_: 1 x_P01,EXA806_T01_ - 1 z_P01,Seg_vesp_ <= 0
liga_turno_P01,EXA806_T01,Qua_vesp_: 1 x_P01,EXA806_T01_ - 1 z_P01,Qua_vesp_ <= 0
liga_turno_P01,EXA806_T02,Ter_mat_: 1 x_P01,EXA806_T02_ - 1 z_P01,Ter_mat_ <= 0
liga_turno_P01,EXA806_T02,Qui_mat_: 1 x_P01,EXA806_T02_ - 1 z_P01,Qui_mat_ <= 0
liga_turno_P01,TEC217_TP01,Seg_vesp_: 1 x_P01,TEC217_TP01_ - 1 z_P01,Seg_vesp_ <= 0
liga_turno_P01,TEC217_TP01,Qua_vesp_: 1 x_P01,TEC217_TP01_ - 1 z_P01,Qua_vesp_ <= 0
liga_turno_P01,TEC217_TP02,Ter_vesp_: 1 x_P01,TEC217_TP02_ - 1 z_P01,Ter_vesp_ <= 0
liga_turno_P01,TEC217_TP02,Qui_vesp_: 1 x_P01,TEC217_TP02_ - 1 z_P01,Qui_vesp_ <= 0
liga_turno_P02,EXA806_T01,Seg_vesp_: 1 x_P02,EXA806_T01_ - 1 z_P02,Seg_vesp_ <= 0
liga_turno_P02,EXA806_T01,Qua_vesp_: 1 x_P02,EXA806_T01_ - 1 z_P02,Qua_vesp_ <= 0
liga_turno_P02,EXA806_T02,Ter_mat_: 1 x_P02,EXA806_T02_ - 1 z_P02,Ter_mat_ <= 0
liga_turno_P02,EXA806_T02,Qui_mat_: 1 x_P02,EXA806_T02_ - 1 z_P02,Qui_mat_ <= 0
liga_turno_P02,TEC217_TP01,Seg_vesp_: 1 x_P02,TEC217_TP01_ - 1 z_P02,Seg_vesp_ <= 0
liga_turno_P02,TEC217_TP01,Qua_vesp_: 1 x_P02,TEC217_TP01_ - 1 z_P02,Qua_vesp_ <= 0
liga_turno_P02,TEC217_TP02,Ter_vesp_: 1 x_P02,TEC217_TP02_ - 1 z_P02,Ter_vesp_ <= 0
liga_turno_P02,TEC217_TP02,Qui_vesp_: 1 x_P02,TEC217_TP02_ - 1 z_P02,Qui_vesp_ <= 0
liga_turno_P03,EXA806_T01,Seg_vesp_: 1 x_P03,EXA806_T01_ - 1 z_P03,Seg_vesp_ <= 0
liga_turno_P03,EXA806_T01,Qua_vesp_: 1 x_P03,EXA806_T01_ - 1 z_P03,Qua_vesp_ <= 0
liga_turno_P03,EXA806_T02,Ter_mat_: 1 x_P03,EXA806_T02_ - 1 z_P03,Ter_mat_ <= 0
liga_turno_P03,EXA806_T02,Qui_mat_: 1 x_P03,EXA806_T02_ - 1 z_P03,Qui_mat_ <= 0
liga_turno_P03,TEC217_TP01,Seg_vesp_: 1 x_P03,TEC217_TP01_ - 1 z_P03,Seg_vesp_ <= 0
liga_turno_P03,TEC217_TP01,Qua_vesp_: 1 x_P03,TEC217_TP01_ - 1 z_P03,Qua_vesp_ <= 0
liga_turno_P03,TEC217_TP02,Ter_vesp_: 1 x_P03,TEC217_TP02_ - 1 z_P03,Ter_vesp_ <= 0
liga_turno_P03,TEC217_TP02,Qui_vesp_: 1 x_P03,TEC217_TP02_ - 1 z_P03,Qui_vesp_ <= 0
liga_turno_reversa_P01,Seg_vesp_: -1 x_P01,EXA806_T01_ - 1 x_P01,TEC217_TP01_ + 1 z_P01,Seg_vesp_ <= 0
liga_turno_reversa_P02,Seg_vesp_: -1 x_P02,EXA806_T01_ - 1 x_P02,TEC217_TP01_ + 1 z_P02,Seg_vesp_ <= 0
liga_turno_reversa_P03,Seg_vesp_: -1 x_P03,EXA806_T01_ - 1 x_P03,TEC217_TP01_ + 1 z_P03,Seg_vesp_ <= 0
liga_turno_reversa_P01,Ter_mat_: -1 x_P01,EXA806_T02_ + 1 z_P01,Ter_mat_ <= 0
liga_turno_reversa_P02,Ter_mat_: -1 x_P02,EXA806_T02_ + 1 z_P02,Ter_mat_ <= 0
liga_turno_reversa_P03,Ter_mat_: -1 x_P03,EXA806_T02_ + 1 z_P03,Ter_mat_ <= 0
liga_turno_reversa_P01,Ter_vesp_: -1 x_P01,TEC217_TP02_ + 1 z_P01,Ter_vesp_ <= 0
liga_turno_reversa_P02,Ter_vesp_: -1 x_P02,TEC217_TP02_ + 1 z_P02,Ter_vesp_ <= 0
liga_turno_reversa_P03,Ter_vesp_: -1 x_P03,TEC217_TP02_ + 1 z_P03,Ter_vesp_ <= 0
liga_turno_reversa_P01,Qua_vesp_: -1 x_P01,EXA806_T01_ - 1 x_P01,TEC217_TP01_ + 1 z_P01,Qua_vesp_ <= 0
liga_turno_reversa_P02,Qua_vesp_: -1 x_P02,EXA806_T01_ - 1 x_P02,TEC217_TP01_ + 1 z_P02,Qua_vesp_ <= 0
liga_turno_reversa_P03,Qua_vesp_: -1 x_P03,EXA806_T01_ - 1 x_P03,TEC217_TP01_ + 1 z_P03,Qua_vesp_ <= 0
liga_turno_reversa_P01,Qui_mat_: -1 x_P01,EXA806_T02_ + 1 z_P01,Qui_mat_ <= 0
liga_turno_reversa_P02,Qui_mat_: -1 x_P02,EXA806_T02_ + 1 z_P02,Qui_mat_ <= 0
liga_turno_reversa_P03,Qui_mat_: -1 x_P03,EXA806_T02_ + 1 z_P03,Qui_mat_ <= 0
liga_turno_reversa_P01,Qui_vesp_: -1 x_P01,TEC217_TP02_ + 1 z_P01,Qui_vesp_ <= 0
liga_turno_reversa_P02,Qui_vesp_: -1 x_P02,TEC217_TP02_ + 1 z_P02,Qui_vesp_ <= 0
liga_turno_reversa_P03,Qui_vesp_: -1 x_P03,TEC217_TP02_ + 1 z_P03,Qui_vesp_ <= 0
carga_min_P01_: 4 x_P01,EXA806_T01_ + 4 x_P01,EXA806_T02_ + 4 x_P01,TEC217_TP01_ + 4 x_P01,TEC217_TP02_ >= 4
carga_min_P02_: 4 x_P02,EXA806_T01_ + 4 x_P02,EXA806_T02_ + 4 x_P02,TEC217_TP01_ + 4 x_P02,TEC217_TP02_ >= 4
carga_min_P03_: 4 x_P03,EXA806_T01_ + 4 x_P03,EXA806_T02_ + 4 x_P03,TEC217_TP01_ + 4 x_P03,TEC217_TP02_ >= 4
teto_disciplinas_P01_: -1 g_P01,EXA806_ - 1 g_P01,TEC217_ + 1 g_max >= 0
teto_disciplinas_P02_: -1 g_P02,EXA806_ - 1 g_P02,TEC217_ + 1 g_max >= 0
teto_disciplinas_P03_: -1 g_P03,EXA806_ - 1 g_P03,TEC217_ + 1 g_max >= 0
cobertura_EXA806_T01_: 1 x_P01,EXA806_T01_ + 1 x_P02,EXA806_T01_ + 1 x_P03,EXA806_T01_ = 1
cobertura_EXA806_T02_: 1 x_P01,EXA806_T02_ + 1 x_P02,EXA806_T02_ + 1 x_P03,EXA806_T02_ = 1
cobertura_TEC217_TP01_: 1 x_P01,TEC217_TP01_ + 1 x_P02,TEC217_TP01_ + 1 x_P03,TEC217_TP01_ = 1
cobertura_TEC217_TP02_: 1 x_P01,TEC217_TP02_ + 1 x_P02,TEC217_TP02_ + 1 x_P03,TEC217_TP02_ = 1
Bounds
s_min >= 0
g_max >= 0
General
s_min
g_max
Binary
x_P01,EXA806_T01_
x_P02,EXA806_T01_
x_P03,EXA806_T01_
x_P01,EXA806_T02_
x_P02,EXA806_T02_
x_P03,EXA806_T02_
x_P01,TEC217_TP01_
x_P02,TEC217_TP01_
x_P03,TEC217_TP01_
x_P01,TEC217_TP02_
x_P02,TEC217_TP02_
x_P03,TEC217_TP02_
z_P01,Seg_vesp_
z_P02,Seg_vesp_
z_P03,Seg_vesp_
z_P01,Ter_mat_
z_P02,Ter_mat_
z_P03,Ter_mat_
z_P01,Ter_vesp_
z_P02,Ter_vesp_
z_P03,Ter_vesp_
z_P01,Qua_vesp_
z_P02,Qua_vesp_
z_P03,Qua_vesp_
z_P01,Qui_mat_
z_P02,Qui_mat_
z_P03,Qui_mat_
z_P01,Qui_vesp_
z_P02,Qui_vesp_
z_P03,Qui_vesp_
g_P01,EXA806_
g_P02,EXA806_
g_P03,EXA806_
g_P01,TEC217_
g_P02,TEC217_
g_P03,TEC217_
End
