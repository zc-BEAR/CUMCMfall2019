%%��һ��
%��ѹ�͹ܵ��ݻ�ΪV_0
%һ�����ڵ���������Q_c
%100MPaѹǿ�£�ȼ�͵��ܶȼ�ΪR_0
%160MPaѹǿ�£�ȼ�͵��ܶȼ�ΪR_1
%150MPaѹǿ�£�ȼ�͵��ܶȼ�ΪR_2
%��ά��100MPa�����ſ���һ��ʱ��Ϊt_0;
V_0 = pi*5^2*500;
R_0 = 0.850;
syms R
R_1 = fzero(@(R) 2786.4*log(R)+452.9-160,1);
R_2 = fzero(@(R) 2664.3*log(R)+452.9-150,1);
%syms P
%equ = (0.0289*P^2+3.0765*P+1571.6)*log(R) + 459.2 - P == 0;
%R_P = solve(equ,R,'ReturnConditions',true);

%CΪ����ϵ��
%rΪA��С�װ뾶
%AΪA��С�����
C = 0.85;
r = 0.71;
A = pi*r^2;
Q_0 = C*A*(2*(160-100)/R_1)^0.5;
Q_c = 20*(2+2.4)/2;
syms t_0
fun_0 = @(t_0) (R_1*Q_0*t_0/(t_0+10)-R_0*Q_c/100);
t_0 = fzero(fun_0,0.5);
%��������150MPa �����ſ���һ��ʱ��Ϊt_1,t_2,t_3
%�ֱ��Ӧ����2s 5s  10s�ĵ������ȶ�
%���͹���ȼ�͵�������Ϊ deltaM mg
deltaM = (R_2 - R_0)*V_0;
%����t_1��t_2��t_3����£���Ч�������ֱ�ΪQ_1 Q_2 Q_3
syms t
%����t_1
Q_1 = integral(@(t) C*A*(2*(60-6.57*log(t+1)/R_1)).^0.5,0,2000)/2000;
R_c1 = 0.87;
fun_1 = @(x) 2000*(Q_1*x/(x+10)*R_1-Q_c/100*R_c1) - deltaM;
t_1 = fzero(fun_1,10);
test1 = fun_1(2000);
%�ڼ����ģ��֮�£�ÿ�ο������ŵ�ʱ��Ϊ2.7511ms

%����t_2
Q_2 = integral(@(t) C*A*(2*(60-5.87*log(t+1)/R_1)).^0.5,0,5000)/5000;
R_c2 = 0.88;
fun_2 = @(x) 5000*(Q_2*x/(x+10)*R_1-Q_c/100*R_c2) - deltaM;
t_2 = fzero(fun_2,5);
test2 = fun_2(5000);
%�ڼ����ģ��֮�£�ÿ�ο������ŵ�ʱ��Ϊ1.5160ms

%����t_3
Q_3 = integral(@(t) C*A*(2*(60-5.43*log(t+1)/R_1)).^0.5,0,10000)/10000;
R_c3 = 0.88;
fun_3 = @(x) 10000*(Q_3*x/(x+10)*R_1-Q_c/100*R_c3) - deltaM;
t_3 = fzero(fun_3,0.5);
%�ڼ����ģ��֮�£�ÿ�ο������ŵ�ʱ��Ϊ1.1524ms


%ά��150MPa����Ŀ���ʱ��
Q_00 = C*A*(2*(160-150)/R_1)^0.5;
syms t_4
fun_4 = @(t_4) (R_1*Q_00*t_4/(t_4+10)-R_2*Q_c/100);
t_4 = fzero(fun_4,0.5);
%ά��150MPaÿ�ο���ʱ��Ϊ0.7383ms



%%�ڶ���
%�뷧�뾶��Ϊr_1
%��װ뾶��Ϊr_2
%����Ϊs�����ΪA
r_1 = 1.25;
r_2 = 0.7;
A_k = pi*r_2^2;
k = ((r_1^2+r_2^2)^0.5-r_1)/tand(9);
%ͨ������2�����ݿ�֪����ʱ��Ϊ0.37ms��2.08ms����
%�Ⱥ�����Բ����������������
t1 = 0.37;
t2 = 2.08;
%��t1��t2֮�䣬��׿���������ȫ����״̬������������������
Q0 = C*A*(2*(100-0.5)/R_0).^0.5;
%��0��t1֮�䣬��׵������ٶ���һ������t�ĺ���
syms t
st = @(t) 16.367*t.^2-2.274*t+0.0444;
%ģ�⺯��st��R^2 = 0.9922
dr = @(st) (st*tand(9));
At = @(dt) pi*(2*r_1*dr+dr.^2);
Qct = @(At) C*At*(2*(100-0.5)/R_0).^0.5;
%��Qct���֣��ɵ�0��t1��ȼ���������,�������һ�����ڵ�ȼ����������
Mc = R_0*(Q0*(2.08-0.37)+2*integral(Qct,0,1.9336));

%�ɸ���1
h = 7.239-2.413;
Vs = 20;
rn = 2.5;
%��ѹ״̬�µ�ȼ���ܶ���ΪR_3
R_3 = fzero(@(R) 1538.4*log(R)+452.9-0.5,1);
Mz = R_3*(Vs + pi*rn^2*h)-(Vs)*R_0;
omg =2*pi/(100*Mz/Mc);

%%������
%������Ϊ��ά���͹���ȼ���������ȶ���͹�ֵ�ת��Ӧ�ﵽ�ڶ��������
%���������ֲ����Ϳ�B��C������ʱ�䣬���͹��ڵ�ȼ��ѹǿ����ά�ֺ㶨
%��ʱ�ġ��㶨����ָ��ʱ��仯�Ĺ����У��͹���ȼ�������Ĳ��������ܵ�С

T = pi/omg;
%�����������͹��ת��������TΪ48.0712���룬ԼΪ���Ϳ׹������ڵ�һ��
%Ϊ��ʹȼ�������Ĳ���������С����ҪԤ���ͣ��Ұ�����������Ĺ���ʱ��ֿ�
syms hx
h0 = fzero(@(hx) R_3*(Vs+pi*rn^2*h) - R_0*(Vs + pi*rn^2*hx),1);
%���ݸ���1�����ݣ��ó����ۼ���Ϊ2.35radʱ�����Ŵ�
%����ֻ�и�ѹ�ͱ�ÿ������0.1258T����6.0472ms��ʱ�䷧�Ŵ򿪣�����ʱ�䷧�Źر�

%������ѵĹ��ͺ����Ͳ��Էֱ��ǣ�
%���Ͳ��ԣ�͹��ת������Ϊ0.1307rad/ms
%���Ͳ��ԣ������Ϳ�ʼ��0.3824ms��B��C���Ϳ׽������ͣ����������Ϳ����ڼ��Ϊ2.8324ms

%��������˼�ѹ��D����������һֱ�򿪣���������������������������£�����͹��ת��
Md = Q0*100*R_0;
omg_z =2*pi*(Md+2*Mc)/(100*Mz);
%���һֱ������ѹ��D��͹�ֵ�ת��Ϊ1.6707rad/ms
%��D��һֱ�򿪵�����£����B��C����һ����ڹ��϶���
%�������£�
syms p;
in1 = fzero(@(x) x-omg_z*Mz/(2*pi),1);
Mcg =@(x) R_0*(100*x+x*(2.08-0.37)+2*integral(Qct,0,1.9336))-in1*100;%�˴�����ȼ���ܶȵı仯
in2 = fzero(Mcg,0);
Qp = @(p) C*A*(2*(p-0.5)/R_0).^0.5-in2;
Pg = fzero(Qp,100);
%�������D��һֱ�򿪣�B��C���Ϳ�����һ�����ϵ������
%��ѹ�͹��ڵ�ѹǿ��Ȼ��ά����108.1242MPa����