function [fobj] = compute_fitness(input_threshold,img)
t=input_threshold;
[m1,n1]=size(img);
h=imhist(img);
P=h/(m1*n1);
q1=zeros(1,length(t));
q2=zeros(1,length(t));
u1=zeros(1,length(t));
u2=zeros(1,length(t));
sigma1=zeros(1,length(t));
sigma2=zeros(1,length(t));
F=zeros(1,length(t));
for f=1:length(t)
    for i=1:t(f)
        q1(f)=q1(f)+P(i);
    end
    for i=(t(f)+1):256
        q2(f)=q2(f)+P(i);
    end
    
    for i=1:t(f)
        u1(f)=u1(f)+((i*P(i))/q1(f));
    end
    for i=t(f)+1:256
        u2(f)=u2(f)+((i*P(i))/q1(f));
    end
    
    for i=1:t(f)
        sigma1(f)=sigma1(f)+(((i-u1(f))^2)*(P(i)/q1(f)));
    end
    for i=t(f)+1:256
        sigma2(f)=sigma2(f)+(((i-u2(f))^2)*(P(i)/q2(f)));
    end
    F(f)=(q1(f)*sigma1(f))+(q2(f)+sigma2(f));
end
[fobj]=min(F);
  end
