function result=get_vaild_second_point(first_i,cover_oppotunity,information_of_nodes,number_of_nodes)


second_point=zeros(number_of_nodes,1);
u_x=information_of_nodes(first_i,1);      
u_y=information_of_nodes(first_i,2);
d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%�㵽ֱ�߾��룻
if atan(d_u/cover_oppotunity(6))>cover_oppotunity(4)
    yita=d_u-cover_oppotunity(6)*tan(atan(d_u/cover_oppotunity(6))-cover_oppotunity(4));%yita��ʾ������ȣ�
else
    yita=d_u+cover_oppotunity(6)*tan(atan(-d_u/cover_oppotunity(6))+cover_oppotunity(4));
end

for i=1:number_of_nodes
    t_x=information_of_nodes(i,1);
    t_y=information_of_nodes(i,2);
    d=abs((cover_oppotunity(1)*t_x-t_y+u_y-cover_oppotunity(1)*u_x)/sqrt(cover_oppotunity(1)^2+1));%������ȵ����ƣ�
    a=-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y;%�ڶ������ڵ�һ������Ϸ�
    c=cover_oppotunity(1)*t_x+u_y-cover_oppotunity(1)*u_x-t_y;%�ڶ������ڵ�һ������ҷ�
    e=abs((-1/cover_oppotunity(1)*t_x+u_y+1/cover_oppotunity(1)*u_x-t_y)/sqrt(1/cover_oppotunity(1)^2+1)); %��������С����󸲸ǳ��ȣ�
    if  d<=yita &&a<0 && c<=0&& e<=cover_oppotunity(3)  
       second_point(i,1)=1;
        
    end
end

result=second_point;