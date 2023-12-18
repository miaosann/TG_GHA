function cover_type_sub=generate_cover_type_sub(cover_oppotunity,u_x,u_y,t_x,t_y,information_of_nodes,information_of_element,number_of_nodes,number_of_element,number_of_division)
cover_type_temp=zeros(number_of_nodes,1);

cover_type_sub=zeros(number_of_element,number_of_division*number_of_division);


d_u=(cover_oppotunity(1)*u_x-u_y+cover_oppotunity(2))/sqrt(cover_oppotunity(1)^2+1);
if atan(d_u/cover_oppotunity(6))>cover_oppotunity(4)
    yita=d_u-cover_oppotunity(6)*tan(atan(d_u/cover_oppotunity(6))-cover_oppotunity(4));
else
    yita=d_u+cover_oppotunity(6)*tan(atan(-d_u/cover_oppotunity(6))+cover_oppotunity(4));
end

for i=1:number_of_nodes
    x=information_of_nodes(i,1);
    y=information_of_nodes(i,2);
    a=(cover_oppotunity(1)*x+u_y-cover_oppotunity(1)*u_x-y)*(cover_oppotunity(1)*x+yita*sqrt(1+cover_oppotunity(1)^2)+u_y-cover_oppotunity(1)*u_x-y);
    b=(-1/cover_oppotunity(1)*x+t_y+1/cover_oppotunity(1)*t_x-y)*(-1/cover_oppotunity(1)*x+t_y+1/cover_oppotunity(1)*t_x-cover_oppotunity(3)*sqrt(1+1/cover_oppotunity(1)^2)-y);
    if a<=0&&b<=0
        cover_type_temp(i,1)=0;%点被覆盖为0
    else
        cover_type_temp(i,1)=1;%点不被覆盖为1
        
    end
end


for i=1:number_of_element
    temp=cover_type_temp(information_of_element(i,1),1)+cover_type_temp(information_of_element(i,2),1)+cover_type_temp(information_of_element(i,3),1)+cover_type_temp(information_of_element(i,4),1);
    if temp==4
        cover_type_sub(i,:)=0;
    elseif temp==0
        cover_type_sub(i,:)=1;
    else
        tempax=information_of_nodes(information_of_element(i,1),1);
        tempay=information_of_nodes(information_of_element(i,1),2);
        tempby=information_of_nodes(information_of_element(i,2),2);
       
        size=(tempby-tempay)/number_of_division;
        temp_nodes=zeros(number_of_division+1,number_of_division+1);
        for j=1:number_of_division+1
            for k=1:number_of_division+1
                x=tempax+size*(j-1);
                y=tempay+size*(k-1);
                a=(cover_oppotunity(1)*x+u_y-cover_oppotunity(1)*u_x-y)*(cover_oppotunity(1)*x+yita*sqrt(1+cover_oppotunity(1)^2)+u_y-cover_oppotunity(1)*u_x-y);
                b=(-1/cover_oppotunity(1)*x+t_y+1/cover_oppotunity(1)*t_x-y)*(-1/cover_oppotunity(1)*x+t_y+1/cover_oppotunity(1)*t_x-cover_oppotunity(3)*sqrt(1+1/cover_oppotunity(1)^2)-y);
                if a<=0&&b<=0
                    temp_nodes(j,k)=0;%点被覆盖为0
                else
                    temp_nodes(j,k)=1;%点不被覆盖为1
                    
                end
            end
        end
        index=0;
        for j=1:number_of_division
            for k=1:number_of_division
                index=index+1;
                if (temp_nodes(j,k)+temp_nodes(j+1,k)+temp_nodes(j,k+1)+temp_nodes(j+1,k+1))==0
                    cover_type_sub(i,index)=1;
                end
            end
        end
    end
end

