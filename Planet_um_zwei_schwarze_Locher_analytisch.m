clear

V1(1,:) = [0,8.4830490549];

X1(1,:) = [85.7125748029,0];

m1 = 100;
m2 = 10000;
m3 = 1

r1 = 100.

dT = 0.001;
T  = 150;

G  = 1;

l = round(T/dT);
r2 = m1/m2 * r1

if r1 == 0
    w = 0;
else
    w = sqrt(G * (m2^3/((m1+m2)^2*abs(r1)^3)));
end

for i = 1:l
    
%     B1 = Trajektorie(r1,w,0,1,i);
%     B2 = Trajektorie(r2,w,pi,1,i);
    
    B1(i,1) = r1 * cos(w*dT*i);
    B1(i,2) = r1 * sin(w*dT*i);
    
    B2(i,1) = r2 * cos(w*dT*i+pi);
    B2(i,2) = r2 * sin(w*dT*i+pi);
    
    V1 = Velocity(V1,X1,B1,B2,i,G,dT,m1,m2);
    X1 = Position(X1,V1,i,dT);

end


figure(2)

plot(0,0, B1(:,1),B1(:,2),B2(:,1),B2(:,2),X1(:,1),X1(:,2))

%axis([-520, 520, -520, 520])
axis([-120, 120, -120, 120])


function [B] = Trajektorie(r,w,c,dT,i)

    B(i,1) = r * cos(w*dT*i+c);
    B(i,2) = r * sin(w*dT*i+c);
    
end

function [V] = Velocity(V,X,B1,B2,i,G,dT,m1,m2)

    V(i+1,1) = V(i,1) - dT * G * m1 * (X(i,1)-B1(i,1)) / sum((X(i,:)-B1(i,:)).^2)^(3/2) - dT * G * m2 * (X(i,1)-B2(i,1)) / sum((X(i,:)-B2(i,:)).^2)^(3/2);
    V(i+1,2) = V(i,2) - dT * G * m1 * (X(i,2)-B1(i,2)) / sum((X(i,:)-B1(i,:)).^2)^(3/2) - dT * G * m2 * (X(i,2)-B2(i,2)) / sum((X(i,:)-B2(i,:)).^2)^(3/2);
end

function [X] = Position(X,V,i,dT)

    X(i+1,1) = X(i,1) + V(i,1) * dT;
    X(i+1,2) = X(i,2) + V(i,2) * dT;
end


