clear
%parpool open

V1(1,:) = [0,sqrt(10)/30];
V2(1,:) = [0,-sqrt(10)/30];

X1(1,:) = [100,0];
X2(1,:) = [-100,0];

m1 = 10;
m2 = 10;

dT = 0.1;
T  = 4000;

l = round(T/dT);

G  = 1;


for i = 1:l
    
    V1s=V1
    V2s=V2
    X1s=X1
    X2s=X2
    
    for k = 1:2
        if k == 1 
            
            V1 = Velocity(V1s,X1,X2,i,G,dT,m1,m2);
            X1 = Position(X1s,V1,i,dT);
            
        else
             
            V2 = Velocity(V2s,X2,X1,i,G,dT,m2,m1);
            X2 = Position(X2s,V2,i,dT);
            %V2(i+1,:) = V2(i,:);
            %X2(i+1,:) = X2(i,:);
        end
    end

end


figure(1)

plot(0,0, X1(:,1),X1(:,2),X2(:,1),X2(:,2))

axis([-120, 120, -120, 120])


function [V] = Velocity(V,X1,X2,i,G,dT,m1,m2)

    V(i+1,1) = V(i,1) - dT * G * m2 * (X1(i,1)-X2(i,1)) / sum((X1(i,:)-X2(i,:)).^2)^(3/2);
    V(i+1,2) = V(i,2) - dT * G * m2 * (X1(i,2)-X2(i,2)) / sum((X1(i,:)-X2(i,:)).^2)^(3/2);
end

function [X] = Position(X,V,i,dT)

    X(i+1,1) = X(i,1) + V(i,1) * dT;
    X(i+1,2) = X(i,2) + V(i,2) * dT;
end