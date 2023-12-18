function result=get_vaild_near_second_point(near_first_i,cover_oppotunity,information_of_nodes_son,number_of_nodes_son,threshold_value,center)


near_second_point=zeros(number_of_nodes_son,1);
u_x=information_of_nodes_son(near_first_i,1);      
u_y=information_of_nodes_son(near_first_i,2);
d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%点到直线距离；
if atan(d_u/cover_oppotunity(6))>cover_oppotunity(4)
    yita=d_u-cover_oppotunity(6)*tan(atan(d_u/cover_oppotunity(6))-cover_oppotunity(4));%yita表示条带宽度；
else
    yita=d_u+cover_oppotunity(6)*tan(atan(-d_u/cover_oppotunity(6))+cover_oppotunity(4));
end
for i=1:number_of_nodes_son
    t_x=information_of_nodes_son(i,1);
    t_y=information_of_nodes_son(i,2);
    d=abs((cover_oppotunity(1)*t_x-t_y+u_y-cover_oppotunity(1)*u_x)/sqrt(cover_oppotunity(1)^2+1));%条带宽度的限制；

    a=-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y;
    
    c=cover_oppotunity(1)*t_x+u_y-cover_oppotunity(1)*u_x-t_y;

    e=abs((-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y)/sqrt(1/cover_oppotunity(1)^2+1)); %条带长度小于最大覆盖长度；
    if  d<=yita &&a<0 && c<=0&& e<=cover_oppotunity(3)  
       near_second_point(i,1)=1;
        
    end
end

center_i=center(1);
center_j=center(2);
for i=1:number_of_nodes_son
    
        if  near_second_point(i,1)==1
            distance=sqrt((center_i-information_of_nodes_son(i,1))^2+(center_j-information_of_nodes_son(i,2))^2);
            if distance>threshold_value
                near_second_point(i,1)=0;
            end
        end
    end




result=near_second_point;