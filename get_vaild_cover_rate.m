function vaild_cover_rate=get_vaild_cover_rate(cover_oppotunity,u_x,u_y,t_x,t_y,cover_type,information_of_nodes,information_of_element,V,mesh_size)
d_u=abs((cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1));
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
vaild_cover_rate=V/(length*yita/(mesh_size*mesh_size));