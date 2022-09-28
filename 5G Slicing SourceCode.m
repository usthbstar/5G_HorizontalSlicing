clear all;
clc;
Nvno=3;

Nserv=3;


Rcrrm=[612 626 646 668 684 812 832 956 970 1100 1114 1242 1258 1292 1386 1402 2586 5172];

Nst=Nvno*Nserv;

lambda=[50 40 30 ;
        25 20 15 ;
         5  4  3 ];

for jj=1:18
        
 
Nuser=[40 100 60; 
       40 100 60;
       40 100 60];


Rv_serv_min=[0.032 0.5 4;
             0.032 0.5 4;
             0       0 0];
           
Rv_serv_max=[0.064 1 Rcrrm(jj);
             0.064 1 Rcrrm(jj);
             0.064 1 Rcrrm(jj)];
         
Rvno_Min=[0.4*Rcrrm(jj) 0.4*Rcrrm(jj) 0];

Rvno_Max=[0.7*Rcrrm(jj) Rcrrm(jj) Rcrrm(jj)];

cvx_begin ;

	variable Wuser(Nst,max(max(Nuser)));

	sm=0;

	for i=1:Nst
	   
		sn=0;
		
		for j=1:Nuser(i)

			sn=sn+(Wuser(i,j)*(Rv_serv_max(i))/Rcrrm(jj));
		
		end
		
		sm=sm+lambda(i)*log(sn);

	end

maximize(sm);


subject to

        
	for i=1:Nst
		
		for j=1:Nuser(i)
			
			Rv_serv_min(i)<=Wuser(i,j)*Rv_serv_max(i)<=Rv_serv_max(i);
		
		end
		
	end

	sum1=0;
	sum2=0;
	sum3=0;
	for i=1:3:Nst % i must step by 3
		for j=1:Nuser(i)
			sum1=sum1+(Wuser(i,j)*Rv_serv_max(i));
			
			sum2=sum2+(Wuser(i+1,j)*Rv_serv_max(i+1));
			
			sum3=sum3+(Wuser(i+2,j)*Rv_serv_max(i+2));
		end
	end

	Rvno_Min(1)<= sum1<=Rvno_Max(1);
	
	Rvno_Min(2)<= sum2<=Rvno_Max(2);
	
	Rvno_Min(3)<= sum3<=Rvno_Max(3);

	%[m,n]=size(Rvno_Min);
    sum4=0;
	for i=1: Nst
	 for j=1:Nuser(i)
		sum4=sum4+Wuser(i,j)*Rv_serv_max(i);
		%Rvno_Min(i)<=sum<=Rvno_Max(i);
	 end
	end

	sum4<=Rcrrm(jj);
cvx_end; 

Wuser=Wuser(:,1);

input(:,jj)=Wuser;





end

target=Rcrrm;

save(['C:\Users\user\Desktop\Nouveau dossier\input','.mat'],'input');
save(['C:\Users\user\Desktop\Nouveau dossier\target','.mat'],'target');
