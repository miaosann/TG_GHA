function result=get_vaild_first_point(cover_oppotunity,information_of_nodes,number_of_nodes)
first_point=zeros(number_of_nodes,1);
for i=1:number_of_nodes
    u_x=information_of_nodes(i,1);%x����
    u_y=information_of_nodes(i,2);%y����
    d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);%�������µ�켣�ľ��룻
    sigema_u=atan(d_u/cover_oppotunity(6))-cover_oppotunity(4)/2;%��ڽǶ�����
    if abs(sigema_u)<=cover_oppotunity(5)%��ڽ�С������ڽǣ�
       first_point(i,1)=1;
    end
end
% for i=1:number_of_nodes
%     u_x=information_of_nodes(i,1);%x����
%     u_y=information_of_nodes(i,2);%y����
%     d_u=abs((cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1));%�������µ�켣�ľ��룻
%     d=cover_oppotunity(6)*tan(cover_oppotunity(4)+cover_oppotunity(5)/2);
%     if d_u<=d%��ڽ�С������ڽǣ�
%        first_point(i,1)=1;
%        
%     end
% end
result=first_point;
