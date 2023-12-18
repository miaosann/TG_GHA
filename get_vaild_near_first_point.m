function result=get_vaild_near_first_point(cover_oppotunity,information_of_nodes_son,number_of_nodes_son,threshold_value,center)
near_first_point=zeros(number_of_nodes_son,1);
for i=1:number_of_nodes_son
    u_x=information_of_nodes_son(i,1);%x坐标
    u_y=information_of_nodes_son(i,2);%y坐标
    d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%距离星下点轨迹的距离；
    sigema_u=atan(d_u/cover_oppotunity(6))-cover_oppotunity(4)/2;%侧摆角度数；
    if abs(sigema_u)<=cover_oppotunity(5)%侧摆角小于最大侧摆角；
       near_first_point(i,1)=1;
       
    end
end
center_i=center(1);
center_j=center(2);
for i=1:number_of_nodes_son
    
        if  near_first_point(i,1)==1
            distance=sqrt((center_i-information_of_nodes_son(i,1))^2+(center_j-information_of_nodes_son(i,2))^2);
            if distance>threshold_value
                near_first_point(i,1)=0;
            end
        end
    end


result=near_first_point;