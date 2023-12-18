function result=count_number_of_vaild_cover(cover_type,grid_state,number_of_element)
temp=0;
if sum(cover_type(:))~=0
for i=1:number_of_element
    if cover_type(i,1)>grid_state(i,1)
       temp=temp+1;
      
    end
end
end
result=temp;