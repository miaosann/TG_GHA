function result=whether_interior_nodes(number_of_nodes,x,y,test_x,test_y)
index=0;
%通过射线法确定一个点是都在一个多边形区域内部；
for i=1:number_of_nodes
    if (test_x==x(i))&&(test_y==y(i))
        index=1;
        break;
    end
    j=i+1;
    slope=(y(j)-y(i))/(x(j)-x(i));
    cond_1=(x(i)<=test_x)&&(test_x<x(j));
    cond_2=(x(j)<=test_x)&&(test_x<x(i));
    cond_3=(test_y<slope*(test_x-x(i))+y(i));
    cond_4=(test_y-y(i))/(test_x-x(i));
    cond_5=(test_y-y(j))/(test_x-x(j));
    if ((cond_4==slope)||(cond_5==slope))&&(cond_1||cond_2)
        index=1;
        break;
    elseif (cond_3)&&(cond_1||cond_2)
        index=index+1;
    end

end
if mod(index,2)~=0
    result=1;
else
    result=0;
end