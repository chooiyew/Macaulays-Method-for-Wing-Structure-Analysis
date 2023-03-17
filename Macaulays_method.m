clear;
clc;
p=1.225;

i=1;
for s=0:5:750
    j=1;
    speed(i)=s;
    v=s*1000/3600;
    for AOA=0:1:15
        angle(j)=AOA;
        CL=(0.09.*AOA)+0.4;
        %calculate moment at fixed support
        MW=135*9.81*15.3^2/2;
        MT=1950*9.81*3;
        MF=(7.78*9.81*15.3^2/2)+(7.42*9.81*15.3^2/6);
        MLF(i,j)=(-2.55.*p.*v^2.*CL*(15.3^2)/2)+(2/17.*p.*v^2.*CL*(15.3^3)/3);
        M(i,j)=-MW-MT-MF-MLF(i,j);
        
        %calculate reaction force at fixed support
        WW=-15.3*135*9.81;
        WT=-1950*9.81;
        WF=-(7.78*15.3*9.81)-(0.5*7.42*9.81*15.3);
        LF(i,j)=(2.55.*p.*v^2.*CL*15.3)-(2/34.*p.*v^2.*CL*15.3^2);
        RF(i,j)=-WW-WT-WF-LF(i,j);
        
        k=1;
        for x=0:0.1:15.3
            dist(k)=x;
            %below are all mclauray eqn for moment
            McW(k)=-135*9.81.*(x^4)/24;
            McT(k)=-1950*9.81.*((x-3)^3)/6;
            McF(k)=-(15.2*9.81.*(x^4)/24)+(7.42*9.81.*(x^5)/120/15.3);
            McLF(i,j,k)=(2.55.*p.*v^2.*CL.*(x^4)/24)-((2/17).*p.*v^2.*CL.*(x^5)/120);
            McR(i,j,k)= (RF(i,j)).*(x^3)/6;
            McM(i,j,k)= (M(i,j)).*(x^2)/2;
            
            %for b)
            VW(k)= -135*9.81.*x;
            VF(k)=-(15.2*9.81.*(x))+(7.42*9.81.*(x^2)/2/15.3);
            VLF(i,j,k)=(2.55.*p.*v^2.*CL.*(x))-((2/17).*p.*v^2.*CL.*(x^2)*0.5);
            VR(i,j)= (RF(i,j));
            
            %for c)
            BM1(k)=-135.*9.81.*(x^2)./2;    %for wing weight
            BM2(k)=-1950.*9.81.*(x-3);  %for turbine
            BM3(k)=-15.2*9.81*(x^2)/2+(7.42*9.81*(x^3)/6/15.3);    %for fuel weight
            BM4(i,j,k)=(RF(i,j).*x)+(M(i,j)*(x^0));    %for reaction force and moment
            BM5(i,j,k)=(2.55.*p.*v^2.*CL.*(x^2)/2)-((2/17).*p.*v^2.*CL.*(x^3)/6);  %for lift force
            
            if x<3
                McT(k)=0;
                
                %for b)
                VT(k)=0;
                
                %for c)
                BM2(k)=0;
            elseif x>=3;
                %for b)
                VT(k)=-1950*9.81;
                %for c)
                BM2(k)=-1950.*9.81.*(x-3);
            end

            EID(i,j,k)=McW(k)+McT(k)+McF(k)+McLF(i,j,k)+McR(i,j,k)+McM(i,j,k);
            
            %for b)
            Vfinal(i,j,k)=-VW(k)-VT(k)-VF(k)-VLF(i,j,k)-VR(i,j);
            
            %for c)
            BMfinal(i,j,k)=-BM1(k)-BM2(k)-BM3(k)-BM4(i,j,k)-BM5(i,j,k);
            
            k=k+1;
        end
        j=j+1;
    end
    i=i+1;
end

%for a)
I=max(abs(EID(:)))/(25*10^9*0.5);
length=nthroot(I*6,4);
CSA=length*length;
fprintf('For question A)\nThe cross section of the beam is %5.3f m^2\n\n',CSA)

%for b)

[maxv,idx]=max(abs(Vfinal(:)));
[velocity1,angle1,distance1]=ind2sub(size(Vfinal),idx);
fprintf('For question B)\nThe maximum transverse stress occurs at point x=%.2f,with the conditions of speed %d km per h and angle of attack %d degree.\n\n',dist(distance1),speed(velocity1),angle(angle1))

%for c)

[maxM,idx]=max(abs(BMfinal(:)));
[velocity2,angle2,distance2]=ind2sub(size(BMfinal),idx);
fprintf('For question C)\nThe maximum bending stress occurs at point x=%.2f,with the conditions of speed %d km per h and angle of attack %d degree.\n\n',dist(distance2),speed(velocity2),angle(angle2))

%for d)
D1=squeeze(Vfinal(:,1,1));
D2=squeeze(Vfinal(:,11,1));
D3=squeeze(Vfinal(:,16,1));
subplot(2,3,1)
plot(speed,D1,speed,D2,speed,D3)
ylabel('Max shear force(N)'),xlabel('speed(km/h)'),grid
if (D1(151,1)>0)
    text(max(abs(speed)),max(D1),'angle=0')
    text(max(abs(speed)),max(D2),'angle=10')
    text(max(abs(speed)),max(D3),'angle=15')
elseif (D1(151,1)<0)
    text(max(abs(speed)),min(D1),'angle=0')
    text(max(abs(speed)),min(D2),'angle=10')
    text(max(abs(speed)),min(D3),'angle=15')
end
xline(0,'k-',{'Y'}),yline(0,'k-',{'X'})
title('question d) shear force')

%for e)
E1=squeeze(BMfinal(:,1,1));
E2=squeeze(BMfinal(:,11,1));
E3=squeeze(BMfinal(:,16,1));
subplot(2,3,2)
plot(speed,E1,speed,E2,speed,E3)
ylabel('Max bending moment(Nm)'),xlabel('speed(km/h)'),grid
if (E1(151,1)>0)
    text(max(abs(speed)),max(E1),'angle=0')
    text(max(abs(speed)),max(E2),'angle=10')
    text(max(abs(speed)),max(E3),'angle=15')
elseif (E1(151,1)<0)
    text(max(abs(speed)),min(E1),'angle=0')
    text(max(abs(speed)),min(E2),'angle=10')
    text(max(abs(speed)),min(E3),'angle=15')
end
xline(0,'k-',{'Y'}),yline(0,'k-',{'X'})
title('question e) bending moment')

%for f)
i=i-1;
j=j-1;
k=k-1;
deflection(:,:,:)=EID(:,:,:)./(25*10^9*I);
F1=squeeze(deflection(:,1,154));
F2=squeeze(deflection(:,11,154));
F3=squeeze(deflection(:,16,154));
subplot(2,3,3)
plot(speed,F1,speed,F2,speed,F3)
ylabel('Max deflection(m)'),xlabel('speed(km/h)'),grid
if (F1(151,1)>0)
    text(max(abs(speed)),max(F1),'angle=0')
    text(max(abs(speed)),max(F2),'angle=10')
    text(max(abs(speed)),max(F3),'angle=15')
elseif (F1(151,1)<0)
    text(max(abs(speed)),min(F1),'angle=0')
    text(max(abs(speed)),min(F2),'angle=10')
    text(max(abs(speed)),min(F3),'angle=15')
end
xline(0,'k-',{'Y'}),yline(0,'k-',{'X'})
title('question f) deflection')

c=1;
for a=0:10:151
    speedg(c)=speed(a+1);
    shearg(c,:,:)=Vfinal(a+1,:,:);
    c=c+1;
end
c=1;
maxshearg=max(shearg,[],3);
x=speedg(:);
y=angle(:);
[X,Y]=meshgrid(x,y);
subplot(2,3,4)
surfc(X,Y,maxshearg),title('question g) shear force'),colormap(spring)
ylabel('Angle of attack(degree)'),xlabel('Speed(km/h)'),zlabel('Max shear force(N)')

%for h)
for a=1:10:151
    BMh(c,:,:)=BMfinal(a,:,:);
    c=c+1;
end
c=1;
maxBMh=max(BMh,[],3);
subplot(2,3,5)
surfc(X,Y,maxBMh),title('question h) bending moment')
ylabel('Angle of attack(degree)'),xlabel('Speed(km/h)'),zlabel('Max bendding moment(Nm)')

%for question i)
for a=0:10:151
    deflection_i(c,:,:)=deflection(a+1,:,:);
    c=c+1;
end
maxdeflection_i=max(deflection_i,[],3);
subplot(2,3,6)
surfc(X,Y,maxdeflection_i),title('question i) deflection')
ylabel('Angle of attack(degree)'),xlabel('Speed(km/h)'),zlabel('Max deflection(m)')