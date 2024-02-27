%	Two-stage CMOS op-amp
%
%	Kapetanios Antonios, 10417
%	kapetaat@ece.auth.gr
%
%	Dept. of ECE, AUTh
%	47 - Microelectonics III
%
%	January 2024

% pMOS: M1, M2, M5, M7, M8
% nMOS: M3, M4, M6

clc;
x=17;
CL=(2+0.01*x)*10^(-12); %F
VDD=1.80+0.003*x; %V
VSS=-VDD; %V
VIN_MAX=100e-3; %V
VIN_MIN=-100e-3; %V
% minimum slew rate:
SR=(18+0.01*x)*10^(6); %V/s
% minimum channel length:
L=1e-6; %m
% minimum gain bandwidth:
GB=(7+0.01*x)*1e6; %Hz

% pMOS parameters
kp_prime=2.9352e-5; %A/V^2
VT0p=0.9056; %V
up=0.218; %cm^2/(V*sec)
Coxp=kp_prime/up;

% nMOS parameters
kn_prime=9.6379e-5; %A/V^2
VT0n=0.7860; %V
un=597.7; %cm^2/(V*sec)
Coxn=kn_prime/un;

% Miller capacitance
CC=(.22*CL); %F
I5=SR*CC; %A

% --- First stage ---

	% calculate size parameters S3 and S4
	S3=(I5/(kn_prime*(VSS-VIN_MIN+abs(VT0p)+VT0n)^2));
	S4=S3;

	% calculate the magnitude of pole p3.
	% We need |p3|>>10*GB
	p3=sqrt(2*kn_prime*S3*I5/2)/(2*0.667*Coxn*S3*L*L); %Hz
	if p3-10*GB<10^6
		printf("p3 is too small.\n");
		return;
	endif

	% calculate size parameters S1 and S2
	gm1=GB*CC; %S
	printf("Rz: %12.6f kΩ\n",(1/gm1)*1e-3);
	S1=1;
	S2=S1;

	% calculate size parameters S5 and S8
	b1=kp_prime*S1;
	VDS5=VIN_MAX-VDD+sqrt(I5/b1)+abs(VT0p); %V
	S5=(2*I5/(kp_prime*VDS5^2));
	S8=S5;

% --- Second stage ---

	% calculate size parameter S6
	I4=I5/2; %A
	gm4=sqrt(2*kn_prime*S4*I4); %S
	gm6=2.2*gm1*CL/CC; %S
	S6=(S4*gm6/gm4);
	I6=gm6^2/(2*kn_prime*S6); %A

	% calculate size parameter S7
	S7=(S5*I6/I5);

% --- Print the results ---
printf("CC: %12.6f pF\n", CC*10^(12));
printf("I5: %12.6f μA\n\n", I5*1e6);
printf("S1: %12.6f\n",S1);
printf("S2: %12.6f\n",S2);
printf("S3: %12.6f\n",S3);
printf("S4: %12.6f\n",S4);
printf("S5: %12.6f\n",S5);
printf("S6: %12.6f\n",S6);
printf("S7: %12.6f\n",S7);
printf("S8: %12.6f\n",S8);

Av=2*gm1*gm6/(I5*I6);
printf("\nAv: %12.6f\n", Av);

Pdiss=(I5+I6)*(VDD-VSS)*10^3; %mW
printf("Pdiss: %12.6f mW\n",Pdiss);