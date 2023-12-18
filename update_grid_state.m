function grid_state=update_grid_state(grid_state_subdivision,number_of_element,num)
grid_state=zeros(number_of_element,1);
for i=1:number_of_element
   if sum(grid_state_subdivision(i,:))==num
       grid_state(i,1)=1;
   end
end
