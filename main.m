
tic;
close all
%%%%%%%%%参数设置%%%%%%%%%%%%%%
mesh_size=10;%计算单元格尺寸；
d_mesh_size=30;%剖分单元格尺寸
number_of_approximation=1;%逼近次数
number_of_division=10;%共同覆盖网格剖分次数；
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%省份选择%
%%%%%%%%%%%%%吉林%%%%%%%%%%%%%%%%%
load jilin_border.mat;
load jilin_cover_oppotunity.mat;
polygon_x=JiLin(:,1);
polygon_y=JiLin(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
min_x=min(polygon_x);
max_x=max(polygon_x);
min_y=min(polygon_y);
max_y=max(polygon_y);
number_of_grid_x=ceil((max_x-min_x)/mesh_size);
number_of_grid_y=ceil((max_y-min_y)/mesh_size);
[information_of_nodes,~,initial_state]=get_information_of_grid(d_mesh_size,polygon_x,polygon_y);
number_of_grid=number_of_grid_x*number_of_grid_y-sum(initial_state(:));
%%%%%%%%%%%%%%%%外接网格图像%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cover_temp=zeros(size(cover_oppotunity,1),6);
for i=1:size(cover_oppotunity,1)
    cover_temp(i,1)=(cover_oppotunity(i,4)-cover_oppotunity(i,2))/(cover_oppotunity(i,3)-cover_oppotunity(i,1));
    cover_temp(i,2)=cover_oppotunity(i,2)-((cover_oppotunity(i,4)-cover_oppotunity(i,2))/(cover_oppotunity(i,3)-cover_oppotunity(i,1)))*cover_oppotunity(i,1);
    cover_temp(i,3)=2000;
    cover_temp(i,4)=cover_oppotunity(i,6)/cover_oppotunity(i,5);
    if cover_oppotunity(i,6)>100
        cover_temp(i,5)=3/180*pi;
    else
        cover_temp(i,5)=15/180*pi;
    end
    cover_temp(i,6)=cover_oppotunity(i,5);
end
cover_oppotunity=cover_temp;
number_of_nodes=size(information_of_nodes,1);
number_of_cover_oppotunity=size(cover_oppotunity,1);
cover_type=cell(2,number_of_cover_oppotunity);
for i=1:number_of_cover_oppotunity
    first_point=get_vaild_first_point(cover_oppotunity(i,:),information_of_nodes,number_of_nodes);
    number_of_first_point=sum(first_point(:));
    cover_type{1,i}=cell(2,number_of_first_point);
    cover_type{2,i}=[i];
    first_point_index=0;
    for first_i=1:number_of_nodes
        if first_point(first_i,1)==1
            second_point=get_vaild_second_point(first_i,cover_oppotunity(i,:),information_of_nodes,number_of_nodes);
            first_point_index=first_point_index+1;
            number_of_second_point=sum(second_point(:));
            cover_type{1,i}{1,first_point_index}=cell(1,number_of_second_point);
            cover_type{1,i}{2,first_point_index}=[information_of_nodes(first_i,:)];
            second_point_index=0;
            for second_i=1:number_of_nodes
                if second_point(second_i,1)==1
                    second_point_index=second_point_index+1;
                    cover_type{1,i}{1,first_point_index}{1,second_point_index}=[information_of_nodes(second_i,:)];
                end
            end
        end
    end
end
[information_of_nodes,information_of_element,initial_state]=get_information_of_grid(mesh_size,polygon_x,polygon_y);
number_of_nodes=size(information_of_nodes,1);
number_of_element=size(information_of_element,1);
for approximation_i=1:number_of_approximation
    remainder_cover_type=cover_type;
    c_need_1={};
    c_need_2={};
    grid_state=zeros(number_of_element,1);
    grid_state_subdivision=zeros(number_of_element,number_of_division*number_of_division);
    while size(remainder_cover_type,2)>0
        size(remainder_cover_type,2)
        V=0;
        V_max=0;
        for i=1:size(remainder_cover_type,2)
            temppp=zeros(6,size(remainder_cover_type{1,i},2));
            r_temp=remainder_cover_type{1,i};
            rr_temp=remainder_cover_type{2,i};
            c_temp=cover_oppotunity(remainder_cover_type{2,i},:);
            parfor j=1:size(r_temp,2)
                V_temp=0;
                for k=1:size(r_temp{1,j},2)
                    cover_type_tempp=generate_cover_type( c_temp,r_temp{2,j}(1),r_temp{2,j}(2),r_temp{1,j}{1,k}(1),r_temp{1,j}{1,k}(2),information_of_nodes,information_of_element,number_of_nodes,number_of_element);
                    V=count_number_of_vaild_cover(cover_type_tempp,grid_state,number_of_element);
                    if V>V_temp
                        V_temp=V;
                        temppp(:,j)=[V ;rr_temp; r_temp{2,j}(1) ;r_temp{2,j}(2) ;r_temp{1,j}{1,k}(1);r_temp{1,j}{1,k}(2)];
                    end
                end
            end
            [V,I]=max(temppp(1,:));
            if V>V_max
                V_max=V;
                temp_1=generate_cover_type(cover_oppotunity(temppp(2,I),:),temppp(3,I),temppp(4,I),temppp(5,I),temppp(6,I),information_of_nodes,information_of_element,number_of_nodes,number_of_element);
                temp_2=[temppp(2,I),temppp(3,I),temppp(4,I),temppp(5,I),temppp(6,I)];
            end
        end
        if size(temp_1,1)==0
            break;
        end
        cover_type_sub=generate_cover_type_sub(cover_oppotunity(temp_2(1),:),temp_2(2),temp_2(3),temp_2(4),temp_2(5),information_of_nodes,information_of_element,number_of_nodes,number_of_element,number_of_division);
        real_cover=zeros(number_of_element,1);
        for rc=1:number_of_element
            if temp_1(rc)>grid_state(rc)
                real_cover(rc)=1;
            end
        end
        c_need_1=[c_need_1,real_cover];
        c_need_2=[c_need_2,temp_2];
        remainder_cover_type=update_remainder_cover_type(remainder_cover_type,temp_2);
        grid_state_subdivision=max(grid_state_subdivision,cover_type_sub);
        grid_state=update_grid_state(grid_state_subdivision,number_of_element,number_of_division*number_of_division);
        temp_1=[];
        temp_2=[];
    end
    rate_of_cover=sum(grid_state)/number_of_element;
    if  approximation_i <number_of_approximation
        near_cover_type=cell(2,size(c_need_2,2));
        threshold_value=4*mesh_size;
        mesh_size_son=mesh_size/2;
        [information_of_nodes_son,information_of_element_son,initial_state_son]=get_information_of_grid(mesh_size_son,polygon_x,polygon_y);
        number_of_nodes_son=size(information_of_nodes_son,1);
        number_of_element_son=size(information_of_element_son,1);
        for i=1:size(c_need_2,2)
            near_first_point=get_vaild_near_first_point(cover_oppotunity(c_need_2{i}(1),:),information_of_nodes_son,number_of_nodes_son,threshold_value,[c_need_2{i}(2) c_need_2{i}(3)]);
            number_of_near_first_point=sum(near_first_point);
            near_cover_type{1,i}=cell(2,number_of_near_first_point);
            near_cover_type{2,i}=c_need_2{i}(1);
            near_first_point_index=0;
            for near_first_i=1:number_of_nodes_son
                if near_first_point(near_first_i,1)==1
                    near_second_point=get_vaild_near_second_point(near_first_i,cover_oppotunity(c_need_2{i}(1),:),information_of_nodes_son,number_of_nodes_son,threshold_value,[c_need_2{i}(4) c_need_2{i}(5)]);%获取这个左单元格对应的可用的上单元 格；
                    near_first_point_index=near_first_point_index+1;
                    number_of_near_second_point=sum(near_second_point(:));
                    near_cover_type{1,i}{1,near_first_point_index}=cell(1,number_of_near_second_point);
                    near_cover_type{1,i}{2,near_first_point_index}=[information_of_nodes_son(near_first_i,:)];
                    near_second_point_index=0;
                    for near_second_i=1:number_of_nodes_son
                        if near_second_point(near_second_i,1)==1
                            near_second_point_index=near_second_point_index+1;
                            near_cover_type{1,i}{1,near_first_point_index}{1,near_second_point_index}=[information_of_nodes_son(near_second_i,:)];
                        end
                    end
                end
            end
            
        end
        cover_type=near_cover_type;
        mesh_size=mesh_size_son;
        information_of_nodes=information_of_nodes_son;
        information_of_element=information_of_element_son;
        initial_state=initial_state_son;
        number_of_nodes=number_of_nodes_son;
        number_of_element=number_of_element_son;
    end
end
number_of_grid_x=ceil((max(polygon_x)-min_x)/mesh_size);
number_of_grid_y=ceil((max(polygon_y)-min_y)/mesh_size);
figure(2);
patch(polygon_x,polygon_y,'y');
for i=1:size(c_need_2,2)
    get_image(cover_oppotunity(c_need_2{i}(1),:),c_need_2{i}(2),c_need_2{i}(3),c_need_2{i}(4),c_need_2{i}(5),c_need_1{i},information_of_nodes,information_of_element);
    hold on
end
toc;