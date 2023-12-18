function [information_of_nodes,information_of_element,initial_state]=get_information_of_grid(mesh_size,polygon_x,polygon_y)

%test:get_information_of_grid(10,JiLin(:,1),JiLin(:,2))

min_x=min(polygon_x);
max_x=max(polygon_x);
min_y=min(polygon_y);
max_y=max(polygon_y);
number_of_grid_x=ceil((max(polygon_x)-min_x)/mesh_size);
number_of_grid_y=ceil((max(polygon_y)-min_y)/mesh_size);
interior_nodes=zeros(number_of_grid_x+1,number_of_grid_y+1);
number_of_nodes=length(polygon_x)-1;

%�����ε��ڵ�
for i=1:number_of_grid_x+1
    for j=1:number_of_grid_y+1
        test_x=(i-1)*mesh_size+min_x;
        test_y=(j-1)*mesh_size+min_y;
        interior_nodes(i,j)=whether_interior_nodes(number_of_nodes,polygon_x,polygon_y,test_x,test_y);
    end
end
%���ʼ�������,0��ʾ��Ҫ���ǣ�1��ʾ��Ч����
initial_state=zeros(number_of_grid_x,number_of_grid_y);
for i=1:number_of_grid_x
    for j=1:number_of_grid_y
        temp=interior_nodes(i,j)+interior_nodes(i+1,j)+interior_nodes(i,j+1)+interior_nodes(i+1,j+1);
        if temp>0
            initial_state(i,j)=0;
        else
            initial_state(i,j)=1;
        end
    end
end
nodes=zeros(number_of_grid_x+1,number_of_grid_y+1);%�洢������������Ľڵ㡣
for i=1:number_of_grid_x
    for j=1:number_of_grid_y
        if initial_state(i,j)==0
            nodes(i,j)=1;
            nodes(i,j+1)=1;
            nodes(i+1,j)=1;
            nodes(i+1,j+1)=1;
        end
    end
end
nodes_rank=zeros(number_of_grid_x+1,number_of_grid_y+1);%���ڵ�����
information_of_nodes=[];
nodes_index=0;
for i=1:number_of_grid_x+1
    for j=1:number_of_grid_y+1
        if nodes(i,j)>0
            nodes_index=nodes_index+1;
            nodes_rank(i,j)=nodes_index;
            information_of_nodes(nodes_index,1)=(i-1)*mesh_size+min_x;%�ڵ���Ϣ�����һ�д洢�����ꣻ
            information_of_nodes(nodes_index,2)=(j-1)*mesh_size+min_y;%�ڵ���Ϣ����ڶ��д洢�����ꣻ
        end
    end
end
information_of_element=[];
element_index=0;
for i=1:number_of_grid_x
    for j=1:number_of_grid_y
        if initial_state(i,j)==0
            element_index=element_index+1;
            information_of_element(element_index,1)=nodes_rank(i,j);%��Ԫ�����½ڵ�������
            information_of_element(element_index,2)=nodes_rank(i,j+1);%��Ԫ�����½ڵ�������
            information_of_element(element_index,3)=nodes_rank(i+1,j);%��Ԫ�����Ͻڵ�������
            information_of_element(element_index,4)=nodes_rank(i+1,j+1);%��Ԫ�����Ͻڵ�������
        end
    end
end

            


% %����ͼ��
% for i=1:number_of_grid_x+1
%     plot([(i-1)*mesh_size+min_x (i-1)*mesh_size+min_x],[min_y max_y],'b');
%     hold on;
% end
% for j=1:number_of_grid_y+1
%      plot([min_x max_x],[(j-1)*mesh_size+min_y (j-1)*mesh_size+min_y],'b');
%     hold on;
% end
% 
% patch(polygon_x,polygon_y,'y');%�����ͼ��
% 
% %�ڲ��ڵ�ͼ��
% for i=1:number_of_decompose+1
%   for j=1:number_of_decompose+1
%       if interior_nodes(i,j)==1
%           plot((i-1)*mesh_size,(j-1)*mesh_size,'r.');
%       end
%   end
% end
%         
% aaa(initial_state,mesh_size,min_x,min_y);
