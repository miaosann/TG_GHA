function result=get_vaild_first_point(cover_oppotunity,information_of_nodes,number_of_nodes)
first_point=zeros(number_of_nodes,1);
for i=1:number_of_nodes
    u_x=information_of_nodes(i,1);%x坐标
    u_y=information_of_nodes(i,2);%y坐标
    d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%距离星下点轨迹的距离；
    sigema_u=atan(d_u/cover_oppotunity(6))-cover_oppotunity(4)/2;%侧摆角度数；
    if abs(sigema_u)<=cover_oppotunity(5)%侧摆角小于最大侧摆角；
       first_point(i,1)=1;
    end
end
% for i=1:number_of_nodes
%     u_x=information_of_nodes(i,1);%x坐标
%     u_y=information_of_nodes(i,2);%y坐标
%     d_u=abs((cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1));%距离星下点轨迹的距离；
%     d=cover_oppotunity(6)*tan(cover_oppotunity(4)+cover_oppotunity(5)/2);
%     if d_u<=d%侧摆角小于最大侧摆角；
%        first_point(i,1)=1;
%        
%     end
% end
result=first_point;
