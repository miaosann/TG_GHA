function result=get_vaild_second_point(first_i,cover_oppotunity,information_of_nodes,number_of_nodes)


second_point=zeros(number_of_nodes,1);
u_x=information_of_nodes(first_i,1);      
u_y=information_of_nodes(first_i,2);
d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%点到直线距离；
if atan(d_u/cover_oppotunity(6))>cover_oppotunity(4)
    yita=d_u-cover_oppotunity(6)*tan(atan(d_u/cover_oppotunity(6))-cover_oppotunity(4));%yita表示条带宽度；
else
    yita=d_u+cover_oppotunity(6)*tan(atan(-d_u/cover_oppotunity(6))+cover_oppotunity(4));
end

for i=1:number_of_nodes
    t_x=information_of_nodes(i,1);
    t_y=information_of_nodes(i,2);
    d=abs((cover_oppotunity(1)*t_x-t_y+u_y-cover_oppotunity(1)*u_x)/sqrt(cover_oppotunity(1)^2+1));%条带宽度的限制；
    a=-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y;%第二个点在第一个点的上方
    c=cover_oppotunity(1)*t_x+u_y-cover_oppotunity(1)*u_x-t_y;%第二个点在第一个点的右方
    e=abs((-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y)/sqrt(1/cover_oppotunity(1)^2+1)); %条带长度小于最大覆盖长度；
    if  d<=yita &&a<0 && c<=0&& e<=cover_oppotunity(3)  
       second_point(i,1)=1;
        
    end
end

result=second_point;