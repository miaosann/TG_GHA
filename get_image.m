function result= get_image(cover_oppotunity,u_x,u_y,t_x,t_y,cover_type,information_of_nodes,information_of_element)



d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);
if atan(d_u/cover_oppotunity(6))>cover_oppotunity(4)
    yita=d_u-cover_oppotunity(6)*tan(atan(d_u/cover_oppotunity(6))-cover_oppotunity(4));
else
    yita=d_u+cover_oppotunity(6)*tan(atan(-d_u/cover_oppotunity(6))+cover_oppotunity(4));
end
%yita为条带宽度；
length=0;
for i=1:size(cover_type,1)
    if cover_type(i)==1
    for j=1:4
        xx=information_of_nodes(information_of_element(i,j),1);
        yy=information_of_nodes(information_of_element(i,j),2);
        temp=abs((-1/cover_oppotunity(1)*xx+t_y+1/cover_oppotunity(1)*t_x-yy)/sqrt((-1/cover_oppotunity(1))^2+1));
        if temp>length
            length=temp;
        end
    end
    end
end
  l_1=[cover_oppotunity(1) u_y-cover_oppotunity(1)*u_x];
  l_2=[cover_oppotunity(1) yita*sqrt(1+cover_oppotunity(1)^2)+u_y-cover_oppotunity(1)*u_x];
  u_1=[-1/cover_oppotunity(1) t_y+1/cover_oppotunity(1)*t_x];
  u_2=[-1/cover_oppotunity(1) t_y+1/cover_oppotunity(1)*t_x-length*sqrt(1+1/cover_oppotunity(1)^2) ];
  x=zeros(1,4);
  y=zeros(1,4);
  x(1)=(u_1(2)-l_1(2))/(l_1(1)-u_1(1));
  y(1)=l_1(1)*x(1)+l_1(2);
  x(2)=(u_2(2)-l_1(2))/(l_1(1)-u_2(1));
  y(2)=l_1(1)*x(2)+l_1(2);
   x(3)=(u_2(2)-l_2(2))/(l_2(1)-u_2(1));
  y(3)=l_2(1)*x(3)+l_2(2);
   x(4)=(u_1(2)-l_2(2))/(l_2(1)-u_1(1));
  y(4)=l_2(1)*x(4)+l_2(2);
  %%plot(x,y);
  patch(x,y,'r','FaceAlpha',0.5);